//
//  StatisticsViewController.m
//  kanarci
//
//  Created by Jan Remes on 31.03.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import "StatisticsViewController.h"
#import "KNUIFactory.h"
#import "KNBarChart.h"
#import "KNDataManager.h"

@interface StatisticsViewController ()

@end

@implementation StatisticsViewController {
    UISegmentedControl *_segmentedControl;
    KNBarChart *_monthChart;
}

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
    _segmentedControl = [KNUIFactory segmentedControlWithItems:@[@"DEN",@"TÝDEN",@"MĚSÍC"]];
    _segmentedControl.frame = CGRectMake(20.0, 50.0, 280.0, 30.0);
    _segmentedControl.selectedSegmentIndex = 2;
    
    [self.view addSubview:_segmentedControl];
    
	// Do any additional setup after loading the view.
}


-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    
    KNDataManager *dataManager = [KNDataManager sharedInstance];
    
    [dataManager getMeasuresForMonth:4 year:2013];
    
    _monthChart = [[KNBarChart alloc] initWithFrame:CGRectMake(0, 80, 320, 320) barChartType:KNBarChartMonthType];
    
    [self.view addSubview:_monthChart];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
