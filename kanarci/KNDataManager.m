//
//  DataController.m
//  SmogAlarm
//
//  Created by Vojtech Vrbka on 2/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#define kJsonUrl @"http://www.vrbka.me/smogalarm/"
// #define kJsonUrl @"http:/www.vrbka.me/smogalarm/extreme.php"

#import "KNDataManager.h"
#import <CoreLocation/CoreLocation.h>
#import "Station.h"
#import "AFJSONRequestOperation.h"
#import "KNMeasureDataDocument.h"
#import "COSMDatapointModel.h"
#import "KNCosmService.h"


#define kFilename_icloud @"kanarci_data"
#define kFilename_local @"kanarci_data_local"

const NSString *KNMeasureDataChangedNotification = @"KNMeasureDataDidChange";

@implementation KNDataManager {
    
    NSMutableArray *_measurements;
    NSMetadataQuery *_query;
    KNMeasureDataDocument *_dataDocument;
    Measurement *_currentMeasurement;
}

@synthesize stations, responseData, stationsLoadTime;
@synthesize location, locationManager, delegate;
@synthesize dataLoaded, positionLoaded, positionBlocked, tokenLoaded,iCloudAvailable;



//Singleton
+ (KNDataManager *) sharedInstance {
    
    static KNDataManager *instance = nil;
    
	static dispatch_once_t onceToken;
    
	dispatch_once(&onceToken, ^{
           if (instance == nil) {
	    	instance = [KNDataManager new];
            instance.positionLoaded = NO;
            instance.dataLoaded = NO;
            instance.positionBlocked = NO;
            instance.tokenLoaded = NO;
            
        }

        
	});
    
	return instance;
}

- (id)init {
    
	self = [super init];
    
	if(self) {
        
		_measurements = [self loadMeasurementData];
        
        if(!_measurements) {
            _measurements = [[NSMutableArray alloc] init];
        }
        
        self.iCloudAvailable = NO;
        
        [self checkForICloud];
        
        
	}
    
	return self;
}


#pragma mark -
#pragma mark iCLoud methods

-(void) checkForICloud {
    
    NSURL *ubiq = [[NSFileManager defaultManager]
                   URLForUbiquityContainerIdentifier:nil];
    if (ubiq) {
    
        self.iCloudAvailable = YES;
        
        [self loadDocument];
        
      //  [self performSelectorInBackground:@selector(loadDocument) withObject:nil];
        
    } else {
        self.iCloudAvailable = NO;
        
    }
}

- (void)loadDocument {
    
    NSMetadataQuery *query = [[NSMetadataQuery alloc] init];
    _query = query;
    [query setSearchScopes:[NSArray arrayWithObject:
                            NSMetadataQueryUbiquitousDocumentsScope]];
    NSPredicate *pred = [NSPredicate predicateWithFormat:
                         @"%K == %@", NSMetadataItemFSNameKey, kFilename_icloud];
    [query setPredicate:pred];
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(queryDidFinishGathering:)
     name:NSMetadataQueryDidFinishGatheringNotification
     object:query];
    
    [query startQuery];
    
}

- (void)queryDidFinishGathering:(NSNotification *)notification {
    
    NSMetadataQuery *query = [notification object];
    [query disableUpdates];
    [query stopQuery];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NSMetadataQueryDidFinishGatheringNotification
                                                  object:query];
    
    _query = nil;
    
	[self loadData:query];
    
}

- (void)loadData:(NSMetadataQuery *)query {
    
    if ([query resultCount] == 1) {
        
        NSMetadataItem *item = [query resultAtIndex:0];
        NSURL *url = [item valueForAttribute:NSMetadataItemURLKey];
        KNMeasureDataDocument *doc = [[KNMeasureDataDocument alloc] initWithFileURL:url];
        _dataDocument = doc;
        [_dataDocument openWithCompletionHandler:^(BOOL success) {
            if (success) {
                NSLog(@"iCloud document opened");
        
                
                if ([_measurements count] < [[_dataDocument documentData] count]) {
                    _measurements = [[NSMutableArray alloc] initWithArray:[_dataDocument documentData] copyItems:NO] ;
                } else if ([_measurements count] > [[_dataDocument documentData] count]) {
                    _dataDocument.documentData = [[NSMutableArray alloc] init];
                    
                    [[_dataDocument documentData] removeAllObjects];
                    [[_dataDocument documentData] addObjectsFromArray:_measurements];
                    
                   NSLog( @"%@",[_dataDocument  description]);
                    
                    [self saveICLoudDoc];
                }
                
            } 
        }];
        
	} else {
        
        NSURL *ubiq = [[NSFileManager defaultManager]
                       URLForUbiquityContainerIdentifier:nil];
        NSURL *ubiquitousPackage = [[ubiq URLByAppendingPathComponent:
                                     @"Documents"] URLByAppendingPathComponent:kFilename_icloud];
        
        KNMeasureDataDocument *doc = [[KNMeasureDataDocument alloc] initWithFileURL:ubiquitousPackage];
        _dataDocument = doc;
        
        [doc saveToURL:[doc fileURL]
      forSaveOperation:UIDocumentSaveForCreating
     completionHandler:^(BOOL success) {
         if (success) {
             [doc openWithCompletionHandler:^(BOOL success) {
                 
                 NSLog(@"new document opened from iCloud");
                 
                 if ([_measurements count] > 0) {
                     [[_dataDocument documentData] addObjectsFromArray:_measurements];
                     postNotificationName(KNMeasureDataChangedNotification, self);
                 }
                 
                 
             }];
         }
     }];
        
        
    }
}


-(void) saveICLoudDoc {
    [_dataDocument saveToURL:[_dataDocument fileURL]
            forSaveOperation:UIDocumentSaveForOverwriting
           completionHandler:^(BOOL success) {
               if (success) {
                  NSLog(@"document saved to icloud");
               }
           }];
}


#pragma mark -
#pragma mark net loading methods
    
- (void) loadStationsWithSuccess:(void (^)(NSArray *stations))success
                     failure:(void (^)(NSError *error))failure  {
    
    
    NSURL *url = [NSURL URLWithString:kJsonUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        if ([NSJSONSerialization isValidJSONObject:JSON]) {
              
            NSMutableArray *stationsJSON = [JSON objectForKey:@"stations"];
            
            self.stationsLoadTime = [NSDate dateWithTimeIntervalSince1970:[[JSON objectForKey:@"date"] doubleValue]];
            self.stations = [[NSMutableArray alloc] initWithCapacity:[stationsJSON count]];
             int number = 0;
            
            for (NSDictionary *stationJSON in stationsJSON) {
                Station *station = [[Station alloc] initWithDictionaryData:stationJSON];
                
                [station setNumber:number];
                
                number++;
                
                //if we are not missing information then add..
                if (station.totalQuality != 0) {
                 [self.stations addObject:station];   
                }
             
                
            }
          
            NSArray *retStations = [[NSArray alloc] initWithArray:self.stations];
            
            if(success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    success(retStations);
                });
            }
            
        }

        
    
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response,NSError *error, id JSON) {
        
         NSLog(@"Connection failed: %@", [error description]);
        
        if(failure) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(error);
            });
        }
    }];
    
    [operation start];
    
    
}

#pragma mark
#pragma mark - Location methods

-(void) loadPosition {
    NSLog(@"requesting position");
    self.locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    [locationManager startUpdatingLocation];
}


-(Station *) getNearestStation {
    double minDistance = 99999999.9;
    double distance;
    Station *nearestStation;
    
    for (Station *station in self.stations) {
        distance = [self.location distanceFromLocation:station.location]/1000;
        if(distance < minDistance && [station.totalQuality intValue] > 0) {
            minDistance = distance;
            nearestStation = station;
        }
    }
    return nearestStation;
}

#pragma mark 
#pragma mark - Measurement methods

-(void)saveMeasure:(Measurement *)measure {
    
    [_measurements addObject:measure];
    
    _currentMeasurement = measure;
    
    [self saveMeasureToCosm:measure];
    
    [_currentMeasurement setLocationDataAvailable:NO];
    
    if(self.positionBlocked) {
        postNotificationName(KNMeasureDataChangedNotification, self);
        [self saveDataWithMeasure:measure];
        
    } else if (!self.positionBlocked && !self.positionLoaded) {
        [self loadPosition];
        
    } else if (self.positionLoaded) {
        NSDate* eventDate = self.location.timestamp;
        NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
        if (abs(howRecent) < 120.0) {
            [self setLocationDataToMeasure:measure];
            
        } else {
            [self loadPosition];
        }
    }
    
}

-(void) saveMeasureToCosm:(Measurement *) measurement {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [KNCosmService postMeasurementToCosm:measurement];
    
    });
    

}

-(NSArray *)getAllMeasures {
    return [[NSArray alloc] initWithArray:_measurements];
}

-(void) setLocationDataToMeasure:(Measurement *) measure {
   
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation: self.location completionHandler:
     
     ^(NSArray *placemarks, NSError *error) {
         
         
         //Get nearby address
         
         CLPlacemark *placemark = [placemarks objectAtIndex:0];
         
         //String to hold address
         
         NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
         
         //Print the location to console
         
         NSLog(@"I am currently at %@",locatedAt);
         
         measure.locationDataAvailable = YES;
         measure.thoroughfare = placemark.thoroughfare;
         measure.locality = placemark.locality;
         measure.country = placemark.country;
         measure.latitude = self.location.coordinate.latitude;
         measure.longtitude = self.location.coordinate.longitude;
        
         postNotificationName(KNMeasureDataChangedNotification, self);
         [self saveDataWithMeasure:measure];
         

         
     }];
}

-(void) saveDataWithMeasure:(Measurement *) measure{
    
    [self saveMeasurementData:_measurements];
    if (iCloudAvailable) {
        
        if (![[_dataDocument documentData] containsObject:measure]) {
             [[_dataDocument documentData] addObject:measure];
        }
        
        [self saveICLoudDoc];
    
    }
}


#pragma mark -
#pragma mark NSCoding document saving

-(void) saveMeasurementData:(NSMutableArray *) archive {
    if ([archive count] >= 1 ) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
        NSString *docDir = [paths objectAtIndex:0];
        NSString *fullFileName = [NSString stringWithFormat:@"%@/%@", docDir,kFilename_local];
        [NSKeyedArchiver archiveRootObject:archive toFile:fullFileName];
    }  
    
}

-(NSMutableArray*)loadMeasurementData {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *loadFullFileName = [NSString stringWithFormat:@"%@/%@", docDir,kFilename_local];
  
    return  [[NSMutableArray alloc] initWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:loadFullFileName]];;
}

#pragma mark -
#pragma mark CLLocationManagerDelegate Methods

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    self.location = newLocation;
    [locationManager stopUpdatingLocation];
    NSLog(@"lokace zjistena");
    self.positionLoaded = YES;
    
    if (_currentMeasurement && !_currentMeasurement.locationDataAvailable) {
        [self setLocationDataToMeasure:_currentMeasurement];
    }
    
    
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSString *errorType = ( error.code == kCLErrorDenied) ? @"Pro zapnutí automatického vyhledání nejbližší stanice jděte do Nastavení > Polohové služby a aktivujte SmogAlarm." : @"Neznámá chyba";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Pozice nebyla zjištěna" message:errorType delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    self.positionLoaded = YES;
    self.positionBlocked = YES;
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
   
    switch (status)
    {
        case kCLAuthorizationStatusNotDetermined:
            self.positionBlocked = NO;
            break;
            
        case kCLAuthorizationStatusRestricted:
            self.positionBlocked = YES;
            break;
            
        case kCLAuthorizationStatusDenied:
            self.positionBlocked = YES;
            break;
            
        case kCLAuthorizationStatusAuthorized:
            
            if (self.positionBlocked) {
                self.positionBlocked = NO;
                [self loadPosition];
            }
            
            
            break;
            
        default:
            break;
    }
}


#pragma mark -
#pragma mark - Statistics methods


-(NSArray *) getMeasuresForMonth:(int) month year:(int) year {
  
    //Create start and end dates for calculation
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
       
    NSDateComponents *startDateComponent = [[NSDateComponents alloc] init];
    [startDateComponent setDay:1];
    [startDateComponent setMonth:month];
    [startDateComponent setYear:year];
    
    NSDate *startDate = [calendar dateFromComponents:startDateComponent];
    
    NSDateComponents *endDateComponent = [[NSDateComponents alloc] init];
    [endDateComponent setMonth:1];
//    [endDateComponent setDay:-1];
//    [endDateComponent setHour:24];
    NSDate *endDate = [calendar dateByAddingComponents:endDateComponent toDate:startDate options:0];
    
    
    //Predicate filtering
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(date >= %@) AND (date <= %@)", startDate, endDate];
    
    NSUInteger unitFlags =  NSDayCalendarUnit;
    
    NSDateComponents *components = [calendar components:unitFlags
                                                fromDate:startDate
                                                  toDate:endDate options:0];
    NSInteger days = [components day];
    
    NSArray *filteredArray = [_measurements filteredArrayUsingPredicate:predicate];
    
    NSMutableArray *returnedArray = [[NSMutableArray alloc] initWithCapacity:33];
    
    
    
    int currentDay = 1;
    
 
    for (Measurement *m in filteredArray) {
        
        NSDateComponents *dayComponents = [calendar components:NSDayCalendarUnit  fromDate:m.date];
        NSInteger measurementDay = [dayComponents day];
        
        while (currentDay < measurementDay) {
            [returnedArray addObject:[NSNumber numberWithInt:0]];
            currentDay++;
        }
        
        if ([returnedArray count] >= currentDay) {
            
            if ([[returnedArray objectAtIndex:measurementDay-1] intValue] < m.bucketValue) {
               [returnedArray replaceObjectAtIndex:measurementDay-1 withObject:[NSNumber numberWithInt:m.bucketValue]];
            }
            
        } else {
                 [returnedArray addObject:[NSNumber numberWithInt:m.bucketValue]];
        }
        
        
        currentDay = measurementDay;
        
    }
    
    while ([returnedArray count] < days) {
        [returnedArray addObject:[NSNumber numberWithInt:0]];
    }
    
    
    return [NSArray arrayWithArray:returnedArray];

}




@end
