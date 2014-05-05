//
//  MapViewController.m
//  kanarci
//
//  Created by Jan Remes on 22.03.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import "MapViewController.h"
#import "Station.h"
#import "StationAnnotation.h"
#import "KNDataManager.h"
#import "StationViewController.h"

@interface MapViewController () <MKMapViewDelegate>

@property(nonatomic,strong) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) NSMutableArray *annotations;
@property (nonatomic,assign) BOOL stationsChmuLoaded;
@property (nonatomic,assign) BOOL stationsKanarciLoaded;
@end

@implementation MapViewController

@synthesize mapView = _mapView;
@synthesize lastCoordination;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    self.annotations = [NSMutableArray array];
}


-(void) loadData{
    
    if (!self.stationsChmuLoaded) {
        [[KNDataManager sharedInstance] loadStationsWithSuccess:^(NSArray *stations){
            
            NSMutableArray *annot = [NSMutableArray arrayWithCapacity:[stations count]];
            for(Station *station in stations) {
                [annot addObject:[StationAnnotation annotationForStation:station]];
                
            }
            [self.annotations addObjectsFromArray:annot];
            self.stationsChmuLoaded = YES;
            
            [self updateMapView];
            
            
            
        } failure:^(NSError *error){
            NSLog(@"Downloading stations failed");
        }];
    }

    
    if (!self.stationsKanarciLoaded) {
        [[KNDataManager sharedInstance] loadKanarciWithSuccess:^(NSArray *stations) {
            
            NSMutableArray *annot = [NSMutableArray arrayWithCapacity:[stations count]];
            for(Station *station in stations) {
                
                if (station.location) {
                    [annot addObject:[StationAnnotation annotationForStation:station]];
                }
                
                
            }
            
            [self.annotations addObjectsFromArray:annot];
            self.stationsKanarciLoaded = YES;
             [self updateMapView];
            
        } failure:^(NSError *error) {
            
        }];
    }
    


}

-(void)updateMapView {
    if(self.mapView.annotations) [self.mapView removeAnnotations:self.mapView.annotations];
    
    
    
    if(self.annotations) {
        [self.mapView addAnnotations:self.annotations];
        
        if ([[KNDataManager sharedInstance] positionLoaded]) {
            
            CLLocation *userLocation = [[KNDataManager sharedInstance] location];
            
            MKCoordinateSpan span = {.latitudeDelta =  3, .longitudeDelta =  3};
            MKCoordinateRegion region = {userLocation.coordinate, span};
            [self.mapView setRegion:region];
            
        } else {

            MKCoordinateRegion viewRegion;
            
            
            MKMapRect region = [self mapRectForAnnotations:[NSArray arrayWithArray:self.annotations]];
            viewRegion = MKCoordinateRegionForMapRect(region);
            
            
            MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
            
            [_mapView setRegion:adjustedRegion animated:YES];
        }
    

    

        
        }
    
    //   NSLog([[NSString alloc] initWithFormat:@"annotations %d",[self.annotations count]]);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = @"Zpět";
    
    [self.navigationController setNavigationBarHidden:YES];
     
    NSDate *lastStationLoadTime = [[KNDataManager sharedInstance] stationsLoadTime];
    
    // IF no data was previously loaded, or time interval since last fetch is larger than 10min
    if ([self.annotations count] == 0 || [lastStationLoadTime timeIntervalSinceNow] > 600.0 ) {
        
        CLLocationCoordinate2D coord ;
        
        
        coord.latitude = 49.930008;
        coord.longitude = 15.550996;
        
        MKCoordinateSpan span = {.latitudeDelta =  3, .longitudeDelta =  3};
        MKCoordinateRegion region = {coord, span};
        [self.mapView setRegion:region];
        
         [self performSelectorInBackground:@selector(loadData) withObject:nil];
    }
    
    
 
    //[super viewWillAppear:animated];
}

- (MKMapRect) mapRectForAnnotations:(NSArray*)annotationsArray
{
    MKMapRect mapRect = MKMapRectNull;
    
    //annotations is an array with all the annotations I want to display on the map
    for (id<MKAnnotation> annotation in annotationsArray) {
        
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
        
        if (MKMapRectIsNull(mapRect))
        {
            mapRect = pointRect;
        } else
        {
            mapRect = MKMapRectUnion(mapRect, pointRect);
        }
    }
    
    return mapRect;
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setMapView:nil];
    _mapView = nil;
    [super viewDidUnload];
}


#pragma mark - Map delegates

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        
        //   return annotation;
        
        return nil;
    }
    
    
    MKAnnotationView *aView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"MapVC"];
    if(!aView) {
        aView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MapVC"];
        aView.canShowCallout = YES;
        aView.calloutOffset = CGPointMake(0, -2);
        // aView.leftCalloutAccessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    }
    //    (StationAnnotation*)annotation).station
    aView.image = ((StationAnnotation*)annotation).station.mapPinImage;
    aView.annotation = annotation;
    
    if( ((StationAnnotation*)annotation).station.stationType == kStationTypeCHMU) {
        UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        rightButton.tag =[self.annotations indexOfObject:((StationAnnotation*)annotation)];
        [rightButton addTarget:self
                        action:@selector(showStation:)
              forControlEvents:UIControlEventTouchUpInside];
        aView.rightCalloutAccessoryView = rightButton;
    }


    
    
    
    //[(UIImageView*)aView.leftCalloutAccessoryView setImage:nil];
    return aView;
}



-(IBAction)showStation:(UIButton*)button {
    self.lastCoordination = self.mapView.region;
    
    StationViewController *stationView = [[StationViewController alloc] initWithNibName:@"StationViewController" bundle:nil];
    stationView.station = [[self.annotations objectAtIndex:button.tag] station];
    [self.navigationController pushViewController:stationView animated:YES];
    
    
}


@end
