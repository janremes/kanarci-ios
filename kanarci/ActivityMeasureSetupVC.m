//
//  ActivityMeasureSetupVC.m
//  kanarci
//
//  Created by Jan Remes on 02.02.14.
//  Copyright (c) 2014 Jan Remes. All rights reserved.
//

#import "ActivityMeasureSetupVC.h"
#import "ActivityMeasureVC.h"
#import "KNActivity.h"

@interface ActivityMeasureSetupVC ()
@property (strong, nonatomic) IBOutlet UISwitch *stepsSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *locationSwitch;
@property (strong, nonatomic) IBOutlet UIButton *startButton;

@end

@implementation ActivityMeasureSetupVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBA Actions

- (IBAction)startButtonTapped:(id)sender {


}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
    if ([segue.identifier isEqualToString:@"startMeasureSegue"]) {
        ActivityMeasureVC *vc = segue.destinationViewController;
        KNActivity *activity = [KNActivity new];
        activity.measureLocation = self.locationSwitch.on;
        activity.measureSteps = self.stepsSwitch.on;
        activity.locations = [NSMutableArray array];
        vc.activity = activity;
    }
    
}

@end
