//
//  KNLoginViewController.m
//  kanarci
//
//  Created by Jan Remes on 10.04.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import "KNLoginViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "KNUIFactory.h"
#import "KNUser.h"

@interface KNLoginViewController ()

@end

@implementation KNLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)awakeFromNib {
   
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationItem setTitle:@"Přihlášení"];
    
    [KNUIFactory setupMenuButon:self.loginButton];
    
    
    UIImage *whiteImage = [KNUIFactory imageFromColorButton:[UIColor whiteColor]];
    UIImage *yellowImage = [KNUIFactory imageFromColorButton:[UIColor colorWithRed:255.0/255.0 green:244.0/255.0 blue:101.0/255.0 alpha:1.0]];
    [self.loginButton setBackgroundImage:yellowImage forState:UIControlStateNormal];
    [self.loginButton setBackgroundImage:whiteImage forState:UIControlStateHighlighted];
    
    
 //   [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
  
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setEmailTextField:nil];
    [self setPasswordTextField:nil];
    [self setLoginButton:nil];
    [super viewDidUnload];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _emailTextField) {
        [textField resignFirstResponder];
        [_passwordTextField becomeFirstResponder];
    } else if (textField == _passwordTextField) {

        [self loginButtonClicked:self];
    }
    return YES;
}


- (IBAction)loginButtonClicked:(id)sender {
    
    if ([_passwordTextField.text length] > 1 && [_emailTextField.text length] > 1 ) {
        [[KNUser sharedInstance] setUserId:_emailTextField.text andPassword:_passwordTextField.text error:nil];
         [self dismissModalViewControllerAnimated:YES];
        
    }
    
   
}
@end
