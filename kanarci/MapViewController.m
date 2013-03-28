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

@interface MapViewController ()

@property(nonatomic,strong) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController

@synthesize mapView = _mapView;
@synthesize annotations = _annotations, lastCoordination;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)awakeFromNib {
    [self.tabBarItem setFinishedSelectedImage: [UIImage imageNamed: @"tab_map"] withFinishedUnselectedImage: [UIImage imageNamed: @"tab_map"]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self performSelectorInBackground:@selector(loadData) withObject:nil];
}


-(void) loadData{
    [[KNDataManager sharedInstance] loadStationsWithSuccess:^(NSArray *stations){
        
        NSMutableArray *annot = [NSMutableArray arrayWithCapacity:[stations count]];
        for(Station *station in stations) {
            [annot addObject:[StationAnnotation annotationForStation:station]];
            
        }
        _annotations = annot;
        
    
       [self updateMapView];

        
        
    } failure:^(NSError *error){
        NSLog(@"Downloading stations failed");
    }];
}

-(void)updateMapView {
    if(self.mapView.annotations) [self.mapView removeAnnotations:self.mapView.annotations];
    if(self.annotations) {
        [self.mapView addAnnotations:self.annotations];
    
        MKCoordinateRegion viewRegion;
        
        
        MKMapRect region = [self mapRectForAnnotations:[NSArray arrayWithArray:self.annotations]];
        viewRegion = MKCoordinateRegionForMapRect(region);
        
        
        MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
        
        [_mapView setRegion:adjustedRegion animated:YES];
        [_mapView setShowsUserLocation:true];
    

        
        }
    
    //   NSLog([[NSString alloc] initWithFormat:@"annotations %d",[self.annotations count]]);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    

     
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
    
//    UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//    rightButton.tag = ((StationAnnotation*)annotation).station.number;
//    [rightButton addTarget:self
//                    action:@selector(showStation:)
//          forControlEvents:UIControlEventTouchUpInside];
//    aView.rightCalloutAccessoryView = rightButton;
    
    
    
    //[(UIImageView*)aView.leftCalloutAccessoryView setImage:nil];
    return aView;
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
}

-(IBAction)showStation:(UIButton*)button {
    self.lastCoordination = self.mapView.region;
    
    //    StationViewController *stationView = [[StationViewController alloc] initWithNibName:@"StationViewController" bundle:nil];
    //    stationView.detailType = @"map";
    //    stationView.station = [[[DataController getInstance] stations] objectAtIndex:button.tag];
    
    
}


@end
