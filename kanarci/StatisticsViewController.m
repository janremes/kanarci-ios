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
#import <PNBarChart.h>
#import "KNBarItem.h"

@interface StatisticsViewController () 

@end

@implementation StatisticsViewController {
    UISegmentedControl *_segmentedControl;
    PNBarChart *_barChart;
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
    _segmentedControl.frame = CGRectMake(20.0, 0.0, 280.0, 30.0);
    _segmentedControl.selectedSegmentIndex = 2;
    
    [_segmentedControl addTarget:self action:@selector(segmentedControlChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segmentedControl];
    
 	// Do any additional setup after loading the view.
}


-(void) segmentedControlChanged:(UISegmentedControl *) control {
    
    
    NSArray *barItems = nil;
    
    if (control.selectedSegmentIndex == 2) {
           barItems = [[KNDataManager sharedInstance] getLastBarItemsForDays:20];
    } else if (control.selectedSegmentIndex == 1 ) {
        barItems = [[KNDataManager sharedInstance] getLastBarItemsForDays:7];
    } else if (control.selectedSegmentIndex == 0) {
        barItems = [[KNDataManager sharedInstance] getLastBarItemsForHours:24];
    }
 
    
   
    NSMutableArray *values = [NSMutableArray array];
    NSMutableArray *colors = [NSMutableArray array];
    NSMutableArray *titles = [NSMutableArray array];
    
  
    
    for (KNBarItem *barItem in [barItems reverseObjectEnumerator]) {
        [values addObject:barItem.value];
        [colors addObject:barItem.color];
        [titles addObject:barItem.title];
    }
    
    [_barChart removeFromSuperview];
    _barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 135.0, self.view.width, 200.0)];
    [_barChart setXLabels:titles];
    [_barChart setYValues:values];
    _barChart.strokeColors = colors;
    [_barChart strokeChart];
    [self.view addSubview:_barChart];
    
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!_barChart) {
        NSMutableArray *values = [NSMutableArray array];
        NSMutableArray *colors = [NSMutableArray array];
        NSMutableArray *titles = [NSMutableArray array];
        
        NSArray *barItems = [[KNDataManager sharedInstance] getLastBarItemsForDays:20];
        
        for (KNBarItem *barItem in [barItems reverseObjectEnumerator]) {
            [values addObject:barItem.value];
            [colors addObject:barItem.color];
            [titles addObject:barItem.title];
        }
        
        _barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 135.0, self.view.width, 200.0)];
        [_barChart setXLabels:titles];
        [_barChart setYValues:values];
        _barChart.strokeColors = colors;
        [_barChart strokeChart];
        
        [self.view addSubview:_barChart];
    }

}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
