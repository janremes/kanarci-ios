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
@synthesize loginButton;

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
    
    //    self.layer.shadowOpacity = 0.3f;
   // self.layer.shadowRadius = 4.0f;
  //  self.layer.shadowOffset = CGSizeMake(0, 3.0f);
    
    [self.navigationController.navigationBar setHidden:YES];
    UIImage *whiteImage = [KNUIFactory imageFromColorButton:[UIColor whiteColor]];
     UIImage *yellowImage = [KNUIFactory imageFromColorButton:[UIColor colorWithRed:255.0/255.0 green:244.0/255.0 blue:101.0/255.0 alpha:1.0]];
    [self.loginButton setBackgroundImage:whiteImage forState:UIControlStateNormal];
    [self.registerButton setBackgroundImage:whiteImage forState:UIControlStateNormal];
    [self.loginButton setBackgroundImage:yellowImage forState:UIControlStateHighlighted];
    [self.registerButton setBackgroundImage:yellowImage forState:UIControlStateHighlighted];
    
    //[self.loginButton setAdjustsImageWhenHighlighted:NO];
    
    
    
  //  [self.loginButton setTitle:@"Přihlaš se" forState:UIControlStateNormal];
    

    self.registerButton.layer.masksToBounds = NO;
    self.registerButton.layer.shadowColor = [UIColor blackColor].CGColor;
    self.registerButton.layer.shadowRadius = 6.0f;
    self.registerButton.layer.shadowOpacity = 0.6f;
    self.registerButton.layer.shadowOffset = CGSizeMake(0, 0);
    [self.registerButton.layer setShadowPath:[[UIBezierPath
                                  bezierPathWithRect:self.registerButton.bounds] CGPath]];
    
    self.loginButton.layer.masksToBounds = NO;
    self.loginButton.layer.shadowColor = [UIColor blackColor].CGColor;
    self.loginButton.layer.shadowRadius = 6.0f;
    self.loginButton.layer.shadowOpacity = 0.6f;
    self.loginButton.layer.shadowOffset = CGSizeMake(0, 0);
    [self.loginButton.layer setShadowPath:[[UIBezierPath
                                  bezierPathWithRect:self.loginButton.bounds] CGPath]];
    
    
	// Do any additional setup after loading the view.
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
