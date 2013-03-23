//
//  MeasureViewController.m
//  kanarci
//
//  Created by Jan Remes on 23.03.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import "MeasureViewController.h"
#import "MeasureBar.h"

@interface MeasureViewController ()

@end

@implementation MeasureViewController {
    MeasureBar *_measureBar;
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
	_measureBar = [[MeasureBar alloc] initWithFrame:CGRectMake(260, 50, 60, 250)];
    
    [self.view addSubview:_measureBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)testButtonTouched:(id)sender {



}



@end
