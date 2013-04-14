//
//  KNLoginViewController.h
//  kanarci
//
//  Created by Jan Remes on 10.04.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KNLoginViewController : UIViewController <UITextFieldDelegate>


@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

- (IBAction)loginButtonClicked:(id)sender;

@end
