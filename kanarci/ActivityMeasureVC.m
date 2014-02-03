//
//  ActivityMeasureVC.m
//  kanarci
//
//  Created by Jan Remes on 02.02.14.
//  Copyright (c) 2014 Jan Remes. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "KNLocationManager.h"

#import "ActivityMeasureVC.h"
#import "KNActivity.h"

@interface ActivityMeasureVC () <MKMapViewDelegate,KNLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *stepCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *stepLabel;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) MKPolyline *polyline;
@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;
@property (strong, nonatomic) NSNumberFormatter *distanceFormatter;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *redoButton;
@end

@implementation ActivityMeasureVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.stepCountLabel.text = @"0";
    self.distanceLabel.text  =  @"0";
    
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.rightBarButtonItem = nil;
    
    self.distanceFormatter = [[NSNumberFormatter alloc] init];
    [self.distanceFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    [[KNLocationManager sharedInstance] setDelegate:self];
    
    if (self.activity.measureSteps) {
        [[KNLocationManager sharedInstance] startObservingStepCount];
        self.activity.startedStepCountingDate = [NSDate new];
    }
    
    if (self.activity.measureLocation) {
        [[KNLocationManager sharedInstance] startObservingLocation];
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [[KNLocationManager sharedInstance] queryStepCounterStartDate:self.activity.startedStepCountingDate endDate:[NSDate new] completion:^(NSInteger stepCount) {
         self.stepCountLabel.text = [NSString stringWithFormat:@"%i",stepCount];
    }];
}

- (IBAction)stopMeasure:(UIButton *)sender {
     [[KNLocationManager sharedInstance] stopObservingLocation];
     [[KNLocationManager sharedInstance] stopObservingStepCount];
     self.navigationItem.rightBarButtonItem = self.redoButton;
    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         sender.alpha = 0.0;
                     }
                     completion:^(BOOL finished){
                         sender.hidden = YES;
                     }];

    
}

- (IBAction)redoButtonTouched:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void) stepCountUpdatedWithCount:(NSInteger) totalNumberOfSteps timestamp:(NSDate *) timestamp error:(NSError *) error{
    self.stepCountLabel.text = [NSString stringWithFormat:@"%i",totalNumberOfSteps];
    
}

-(void) locationUpdated:(CLLocation *) newLocation {


    MKCoordinateRegion region = {{0,0},{.02,.02}};
    region.center.latitude = newLocation.coordinate.latitude;
    region.center.longitude = newLocation.coordinate.longitude;
    [self.mapView setRegion:region animated:YES];

        [self.activity.locations addObject:newLocation];
        NSUInteger count = [self.activity.locations count];
    
        CLLocationCoordinate2D coordinates[count];
    
        CLLocationDistance totalDistance = 0;
        CLLocation *lastLocation = nil;
        for (NSInteger i = 0; i < count; i++) {
            if (lastLocation) {
                totalDistance += [lastLocation distanceFromLocation:self.activity.locations[i]];
                lastLocation = self.activity.locations[i];
            }
            coordinates[i] = [(CLLocation *)self.activity.locations[i] coordinate];
        }
    
        self.distanceLabel.text = [NSString stringWithFormat:@"%@ m", [self.distanceFormatter stringFromNumber:@(totalDistance)]];
    
        MKPolyline *oldPolyline = self.polyline;
        self.polyline = [MKPolyline polylineWithCoordinates:coordinates count:count];
        [self.mapView addOverlay:self.polyline];
        if (oldPolyline)
            [self.mapView removeOverlay:oldPolyline];
    
}


- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKPolyline class]])
    {
        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
        
        renderer.strokeColor = [[UIColor redColor] colorWithAlphaComponent:0.7];
        renderer.lineWidth   = 3;
        
        return renderer;
    }
    
    return nil;
}

@end
