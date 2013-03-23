//
//  DataController.m
//  SmogAlarm
//
//  Created by Vojtech Vrbka on 2/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#define kJsonUrl @"http://www.vrbka.me/smogalarm/"
// #define kJsonUrl @"http:/www.vrbka.me/smogalarm/extreme.php"

#import "DataController.h"
#import <CoreLocation/CoreLocation.h>
#import "Station.h"
#import "AFJSONRequestOperation.h"



@implementation DataController
@synthesize stations, responseData, dataDate;
@synthesize location, locationManager, delegate;
@synthesize dataLoaded, positionLoaded, positionBlocked, tokenLoaded;


// we need to use object instance
static DataController *instance = nil;
+ (DataController *) sharedInstance {
    
    static DataController *instance = nil;
    
	static dispatch_once_t onceToken;
    
	dispatch_once(&onceToken, ^{
           if (instance == nil) {
	    	instance = [DataController new];
            instance.positionLoaded = NO;
            instance.dataLoaded = NO;
            instance.positionBlocked = NO;
            instance.tokenLoaded = NO;
        }

        
	});
    
	return instance;
}



-(void) loadAllData {
//    self.delegate = delegate;
    [self loadStations];
    [self loadPosition];
}

-(void) dataDidFinishLoading {
    NSLog(@"data did finish loading");
    if(self.positionLoaded && self.dataLoaded) {
        [delegate dataDidFinishLoading];
    }    
}
    
- (void) loadStationsWithSuccess:(void (^)(NSArray *stations))success
                     failure:(void (^)(NSError *error))failure  {
    
    
    NSURL *url = [NSURL URLWithString:kJsonUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        if ([NSJSONSerialization isValidJSONObject:JSON]) {
              
            NSMutableArray *stationsJSON = [JSON objectForKey:@"stations"];
            
            self.dataDate = [NSDate dateWithTimeIntervalSince1970:[[JSON objectForKey:@"date"] doubleValue]];
            self.stations = [[NSMutableArray alloc] initWithCapacity:[stationsJSON count]];
             int number = 0;
            
            for (NSDictionary *stationJSON in stationsJSON) {
                Station *station = [[Station alloc] initWithDictionaryData:stationJSON];
                
                [station setNumber:number];
                
                number++;
                
                [self.stations addObject:station];
                
            }
            
            
            NSArray *retStations = [[NSArray alloc] initWithArray:self.stations];
            
            if(success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    success(retStations);
                });
            }
            
        }

        
    
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response,NSError *error, id JSON) {
        
         NSLog([NSString stringWithFormat:@"Connection failed: %@", [error description]]);
        
        if(failure) {
            dispatch_async(dispatch_get_main_queue(), ^{
           
            });
        }
    }];
    
    [operation start];
    
    
}

-(void) loadPosition {    
    // request position
    NSLog(@"requesting position");
    self.locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
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

#pragma mark -
#pragma mark Process loan data
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
//    NSLog(@"new Connection did finish loading");
//    
//    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
//	self.responseData = nil;
//
////    NSMutableArray *stationsJSON = [responseString JSONValue];
//  
//    NSDictionary *dataJSON = [responseString JSONValue];
//    NSMutableArray *stationsJSON = [dataJSON objectForKey:@"stations"];
////    int dateJSON = [[dataJSON objectForKey:@"date"] intValue];
//
//    self.dataDate = [NSDate dateWithTimeIntervalSince1970:[[dataJSON objectForKey:@"date"] doubleValue]];
//    /*
//     {"date":"2012-02-25 19:00","stations":{{"code":"ABRAA","name":"Pha4-BranÃ­k","longitude":"14.411826","latitude":"50.042003","measurement":{"NO2":26.781,"PM10":4},"hourly_index":"2"}     */
//    self.stations = nil;
//    self.stations = [[NSMutableArray alloc] initWithCapacity:[stationsJSON count]];    
//    int number = 0;
//    for (NSDictionary *stationJSON in stationsJSON) {
//        Station *station = [[Station alloc] init];
//        station.code = (NSString*)[stationJSON objectForKey:@"code"];
//        station.name = (NSString*)[stationJSON objectForKey:@"name"];
//
//        // location
//        CLLocationDegrees latitude = [[stationJSON objectForKey:@"latitude"] doubleValue];
//        CLLocationDegrees longitude = [[stationJSON objectForKey:@"longitude"] doubleValue];
//        station.location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
//        station.measurements = [[NSMutableDictionary alloc] init];
//        [((NSDictionary*)[stationJSON objectForKey:@"measurement"]) enumerateKeysAndObjectsUsingBlock:^(id name, id value, BOOL *stop) {
//            [station.measurements setValue:[StationMeasurement stationMeasurementForName:name andValue:value andStation:station] forKey:name];            
//        }];                
//        
//        station.totalQuality = (NSNumber*)[stationJSON objectForKey:@"hourly_index"];
//        if([station.totalQuality intValue] == -1) {
//            station.totalQuality = 0;
//        }
//
//        station.number = number; 
//       
//        
//        [self.stations addObject:station];        
//    }
//
//    NSLog([[NSString alloc] initWithFormat:@"new data loaded (%d stations)",[self.stations count]]);
//    self.dataLoaded = YES;
//    [self dataDidFinishLoading];
}

//
//- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
//	// label.text = [NSString stringWithFormat:@"Connection failed: %@", [error description]];
//    NSString *errorType =  @"Nepodařilo se připojit k serveru a stáhnout data. Zkontrolujte vaše internetové připojení.";
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Chyba při stahování dat" message:errorType delegate:self cancelButtonTitle:@"Zkusit znovu" otherButtonTitles:nil];
//    [alert show];
//    
//    NSLog([NSString stringWithFormat:@"Connection failed: %@", [error description]]);
//    dataLoaded = NO;
//}
//
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    [self loadStations];
//}

#pragma mark -
#pragma mark CLLocationManagerDelegate Methods
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    self.location = newLocation;
    [locationManager stopUpdatingLocation];
    NSLog(@"lokace zjistena");
    self.positionLoaded = YES;
    [self dataDidFinishLoading];
    
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSString *errorType = ( error.code == kCLErrorDenied) ? @"Pro zapnutí automatického vyhledání nejbližší stanice jděte do Nastavení > Polohové služby a aktivujte SmogAlarm." : @"Neznámá chyba";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Pozice nebyla zjištěna" message:errorType delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    self.positionLoaded = YES;
    self.positionBlocked = YES;
    [self dataDidFinishLoading];
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
}




@end
