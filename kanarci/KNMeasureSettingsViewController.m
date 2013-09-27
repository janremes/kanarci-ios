//
//  KNMeasureSettingsViewController.m
//  kanarci
//
//  Created by Jan Remes on 27.09.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import "KNMeasureSettingsViewController.h"

@interface KNMeasureSettingsViewController ()
@property (strong, nonatomic) IBOutlet UISwitch *audioSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *bluetoothSwitch;

@end

@implementation KNMeasureSettingsViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)bluetoothSwitched:(UISwitch *)sender {
    if (sender.on) {
        [self.audioSwitch setOn:NO];
    } else {
         [self.audioSwitch setOn:YES];
    }
}

- (IBAction)audioSwitched:(UISwitch *)sender {
    if (sender.on) {
        [self.bluetoothSwitch setOn:NO];
    } else {
        [self.bluetoothSwitch setOn:YES];
    }
}
@end
