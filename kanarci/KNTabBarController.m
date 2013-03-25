//
//  KNTabBarController.m
//  kanarci
//
//  Created by Jan Remes on 25.03.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import "KNTabBarController.h"

@interface KNTabBarController ()

@end

@implementation KNTabBarController

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
    
    //  Set background images using tab bar proxy appearance
	[[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"kn_bg_tabbar"]];
	[[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"kn_tab_bg_active"]];
    
    
    //  Set text
	NSDictionary *textAttributes = @{
                                  UITextAttributeTextColor : [UIColor whiteColor],
                                  UITextAttributeTextShadowColor : [UIColor clearColor]
                                  };
    
	[[UITabBarItem appearance] setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
