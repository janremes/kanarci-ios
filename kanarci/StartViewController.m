//
//  StartViewController.m
//  kanarci
//
//  Created by Jan Remes on 07.04.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import "StartViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "KNUIFactory.h"

@interface StartViewController ()

@end

@implementation StartViewController

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
    
    
    [self.navigationController setNavigationBarHidden:YES];
    
    [KNUIFactory setupMenuButon:self.registerButton];
    [KNUIFactory setupMenuButon:self.loginButton];
    
    
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewDidUnload {
    [self setRegisterButton:nil];
    [self setLoginButton:nil];
    [super viewDidUnload];
}
@end
