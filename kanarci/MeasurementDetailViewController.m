//
//  MeasurementDetailViewController.m
//  kanarci
//
//  Created by Jan Remes on 27.09.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import "MeasurementDetailViewController.h"
#import <MapKit/MapKit.h>
#import "PinAnnotation.h"
#import "KNMeasureHelper.h"
#import "KNFormatter.h"

@interface MeasurementDetailViewController ()
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIImageView *measureImageView;
@property (strong, nonatomic) IBOutlet UILabel *preciseValueLabel;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MeasurementDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.dateLabel.text = [KNFormatter formattedDate:self.measurement.date];
    
    [self.measureImageView setImage:[UIImage imageNamed:[KNMeasureHelper getImageNameForBucketValue:self.measurement.bucketValue]]];
    
    self.preciseValueLabel.text = [NSString stringWithFormat:@"%i ppm",[self.measurement.preciseValue integerValue]];
    
    CLLocationCoordinate2D coord ;
    
    
    coord.latitude = self.measurement.latitude;
    coord.longitude = self.measurement.longtitude;
    
    MKCoordinateSpan span = {.latitudeDelta =  0.01, .longitudeDelta =  0.01};
    MKCoordinateRegion region = {coord, span};
    [self.mapView setRegion:region];
    
    PinAnnotation *annotation = [[PinAnnotation alloc] initWithTitle:@"Měření" andCoordinate:coord] ;
    [_mapView addAnnotation:annotation];
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
