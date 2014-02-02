//
//  MeasureViewController.m
//  kanarci
//
//  Created by Jan Remes on 23.03.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import "MeasureViewController.h"
#import "MeasureBar.h"
#import "KNUIFactory.h"
#import "KNMeasureHelper.h"
#import "KNDataManager.h"
#import "KNUser.h"
#import "KNLoginViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "CVAudioSession.h"
#import "MKBlockAdditions.h"

@interface MeasureViewController ()

@end

@implementation MeasureViewController {
    MeasureBar *_measureBar;
    UILabel *_measuredAirQualityLabel;
    UILabel *_measureDateLabel;
    UIImageView *_kanarImageView;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



-(void) checkLogin {
    
    if ([[KNUser sharedInstance] needsLogin]) {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard"
                                                                 bundle: nil];
        
        
        UINavigationController *navControler = (UINavigationController *)  [mainStoryboard instantiateViewControllerWithIdentifier:@"loginRegisterNavController"];
        
        [self presentViewController:navControler animated:NO completion:nil];
    }
    
}

-(void) settingsTapped:(id) sender {
    [self performSegueWithIdentifier:@"SettingsSegue" sender:self];
}

- (void)viewDidLoad

{
    [super viewDidLoad];
    
    [self checkLogin];
    
    [CVAudioSession setup];
    
    addNotificationObserver(self, newAudioDetected:, kCVAudioInputNewDetectedNotification, nil);
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [button setImage:[UIImage imageNamed:@"settings"] forState:UIControlStateNormal];
    button.showsTouchWhenHighlighted = YES;
    
    [button addTarget:self action:@selector(settingsTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    

    self.navigationItem.rightBarButtonItem = settingsButton;

    
    
    CGFloat descLabelSize = 15.0;
    
    UILabel *airQualityLabel = [KNUIFactory labelWithFontSize:descLabelSize bold:NO];
    
    [airQualityLabel setFrame:CGRectMake(15, 10, 100, 20)];
    
    [airQualityLabel setText:@"kvalita ovzduší:"];
    
    [self.view addSubview:airQualityLabel];
    
    UILabel *dustLabel = [KNUIFactory labelWithFontSize:descLabelSize bold:NO];
    
    [dustLabel setFrame:CGRectMake(260, 10, 100, 20)];
    
    [dustLabel setText:@"prach"];
    
    [self.view addSubview:dustLabel];
    
    UILabel *timeLabel = [KNUIFactory labelWithFontSize:descLabelSize bold:NO];
    
    [timeLabel setFrame:CGRectMake(15, 300, 100, 20)];
    
    [timeLabel setText:@"aktualizováno:"];
    
    [self.view addSubview:timeLabel];
    
    timeLabel.bottom = self.tabBarController.tabBar.top - 100;
    
    
    _measureDateLabel = [KNUIFactory labelWithFontSize:15.0 bold:YES];
    

    [_measureDateLabel setFrame:CGRectMake(15, 320, 150, 20)];
    
     _measureDateLabel.bottom = self.tabBarController.tabBar.top - 80;
    
    [self setMeasureDateTitle:[NSDate new]];
    
    [self.view addSubview:_measureDateLabel];
    
    _measuredAirQualityLabel = [KNUIFactory labelWithFontSize:21.0 bold:YES];
    
    [_measuredAirQualityLabel setFrame:CGRectMake(15, 30, 200, 30)];
    
    [self setMeasureQualityTitle:0];
    
    [self.view addSubview:_measuredAirQualityLabel];
    
	_measureBar = [[MeasureBar alloc] initWithFrame:CGRectMake(260, 70, 60, 250)];
    
    [self.view addSubview:_measureBar];
    
    _kanarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, 250, 234)];
    
    [self.view addSubview:_kanarImageView];
    
    [self setKanarImage:0];
    
    
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    

}

-(void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self setDefaults];
}


-(void) newAudioDetected:(NSNotification *) notification {
    [UIAlertView alertViewWithTitle:@"Kanárek připojen" message:@"Chcete přenést data?" cancelButtonTitle:@"Cancel" otherButtonTitles:@[@"Ok"] onDismiss:^(int buttonIndex, UIAlertView *alertView) {
        [self performSelector:@selector(testButtonTouched:) withObject:nil afterDelay:2.0];
    } onCancel:^{
        
    }];
}


-(void) updateWithMeasure:(Measurement *) measurement {
    
    [self setMeasureDateTitle:[measurement date]];
    [self setMeasureQualityTitle:[measurement bucketValue]];
    [_measureBar updateArrowToValue:[measurement bucketValue]];
    [self setKanarImage:[measurement bucketValue]];
    
}


-(void) setDefaults {
    [self setKanarImage:0];
    [self setMeasureQualityTitle:0];
    [self setMeasureDateTitle:nil];
}

-(void) setKanarImage:(int) value {
    
    NSString *imageName =[ NSString stringWithFormat:@"kanar%d",value ];
    
//    [UIView transitionWithView:self.view
//                      duration:1.0
//                       options:UIViewAnimationOptionTransitionCrossDissolve
//                    animations:^{
//                            [_kanarImageView setImage:[UIImage imageNamed:imageName]];
//                    } completion:nil];
    
    [UIView animateWithDuration:0.9
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                       [_kanarImageView setImage:[UIImage imageNamed:imageName]];;
                         
                     }
                     completion:^(BOOL finished){
                         //   NSLog(@"Arrow moved!");
                     }];
    
}


-(void) setMeasureQualityTitle:(int) value {

    [_measuredAirQualityLabel setText:[[KNMeasureHelper getQualityStringForValue:value] uppercaseString]];
    
}

-(void) setMeasureDateTitle:(NSDate *) date {
    
    if (date) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EE d/MM/yy '|' HH:mm"];
        
        
        [_measureDateLabel setText:[dateFormatter stringFromDate:date]];
    } else {
        [_measureDateLabel setText:@""];
    }
    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)testButtonTouched:(id)sender {
    Measurement *newMeasurement = [[Measurement alloc] init];
    newMeasurement.bucketValue = (arc4random() % 6) + 1;
    newMeasurement.preciseValue = [NSNumber numberWithInt:(arc4random() % 100) + 1];
    newMeasurement.date = [NSDate new];
    
    [self updateWithMeasure:newMeasurement];
    [[KNDataManager sharedInstance] saveMeasure:newMeasurement];
    


}



@end
