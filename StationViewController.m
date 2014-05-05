//
//  StationViewController.m
//  kanarci
//
//  Created by Jan Remes on 05.05.14.
//  Copyright (c) 2014 Jan Remes. All rights reserved.
//

#import "StationViewController.h"
#import "Station.h"
#import "StationMeasurement.h"
#import "KNDataManager.h"
#import "StationRowView.h"

@interface StationViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *canarImageView;
@property (strong, nonatomic) IBOutlet UILabel *qualityLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) NSMutableArray *rows;
@end

@implementation StationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    
    
    self.navigationItem.title = self.station.name;
    self.qualityLabel.text = self.station.qualityString;
    NSString *canarImageName = [NSString stringWithFormat:@"kanar%ld.png",(long)self.station.totalQuality.integerValue];
    self.canarImageView.image = [UIImage imageNamed:canarImageName];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterLongStyle;
    self.dateLabel.text = [dateFormatter stringFromDate:[[KNDataManager sharedInstance] stationsLoadTime]];

    self.rows = [NSMutableArray array];
    [self setupScrollView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self animateRows];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.scrollView.height = self.view.height - self.scrollView.top - 50;
}

-(void) animateRows {
    for(StationRowView *row in self.rows) {
        [row animate];
    }
}

-(void) setupScrollView{
    CGFloat height = 0;
    for(NSString *key in self.station.measurements.allKeys) {
        StationRowView *row = [[StationRowView alloc] initWithFrame:CGRectMake(0, height, self.view.width, 50)];
        [row setupWithStationMeasurement:[self.station.measurements objectForKey:key]];
        [self.scrollView addSubview:row];
        height+=row.height;
        [self.rows addObject:row];
    }
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width, height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
