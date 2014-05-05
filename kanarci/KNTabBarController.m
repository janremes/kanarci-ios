//
//  KNTabBarController.m
//  kanarci
//
//  Created by Jan Remes on 25.03.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import "KNTabBarController.h"
#import "KNTabBarCenterButton.h"


#define CENTER_TAB_INDEX 2

@implementation KNTabBarController {
 
        
    KNTabBarCenterButton *_tabbarCenterButton;
   
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
	// Do any additional setup after loading the view.
    
    //  Set background images using tab bar proxy appearance
	[[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"kn_bg_tabbar"]];
	[[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"kn_tab_bg_active"]];
    
    
        UITabBar *tabbar = self.tabBar;
    UITabBarItem *mapItem = tabbar.items[0];
    [mapItem setImage:[[UIImage imageNamed: @"tab1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [mapItem setSelectedImage:[[UIImage imageNamed: @"tab1"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    UITabBarItem *statsItem = tabbar.items[1];
    [statsItem setImage:[[UIImage imageNamed: @"tab2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [statsItem setSelectedImage:[[UIImage imageNamed: @"tab2"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

    
    UITabBarItem *infoItem = tabbar.items[3];
    [infoItem setImage:[[UIImage imageNamed: @"tab4"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [infoItem setSelectedImage:[[UIImage imageNamed: @"tab4"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

    
    UITabBarItem *profilItem = tabbar.items[4];
    [profilItem setImage:[[UIImage imageNamed: @"tab5"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [profilItem setSelectedImage:[[UIImage imageNamed: @"tab5"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];


    
    //  Set text
	NSDictionary *textAttributes = @{
                                  UITextAttributeTextColor : [UIColor whiteColor],
                                  UITextAttributeTextShadowColor : [UIColor clearColor]
                                  };
    
	[[UITabBarItem appearance] setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UITabBar *tabbar = self.tabBar;
    
	UITabBarItem *centerItem = ([tabbar.items count] >= 2 ? tabbar.items[2] : nil);
    
	//  Create custom center tabbar button
	if(centerItem && !_tabbarCenterButton) {
        
		KNTabBarCenterButton *centerButton = [[KNTabBarCenterButton alloc] initWithFrame:CGRectMake(0, 0, 64, 64)];
        
        centerButton.layer.cornerRadius = centerButton.width/2;
		centerButton.normalBackgroundColor = [UIColor blackColor];
		centerButton.highlightedBackgroundColor = [UIColor blackColor];
        
		centerButton.normalImage = [UIImage imageNamed:@"tab3"];
		      
		centerButton.titleText = @"měření";
        centerButton.highlightedImage = [UIImage imageNamed:@"tab3-active"];
       // centerButton.normalImage = [UIImage imageNamed:@"tab_measure"];
        
        
		//    centerButton.frame = CGRectMake(0, 0, self.tabBar.width/5, 52);
		[centerButton addTarget:self action:@selector(doCenterButtonTapped:) forControlEvents:UIControlEventTouchDown];
        
		[self.view addSubview:centerButton];
		centerButton.bottomMargin = 0;
		[centerButton centerHorizontally];
        
		//  Check default style after initialization
		centerButton.highlightedStyle = (self.selectedViewController.tabBarItem == centerItem);
        
		_tabbarCenterButton = centerButton;
	}
}

#pragma mark -
#pragma mark Overrides

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    
	[super setSelectedIndex:selectedIndex];
    
	//  Set style of center button according to currently selected controller
	if(_tabbarCenterButton) {
		_tabbarCenterButton.highlightedStyle = (self.selectedIndex == CENTER_TAB_INDEX);
	}
}

- (void)setSelectedViewController:(UIViewController *)selectedViewController {
    
	[super setSelectedViewController:selectedViewController];
    
	//  Set style of center button according to currently selected controller
	if(_tabbarCenterButton) {
		_tabbarCenterButton.highlightedStyle = (self.selectedIndex == CENTER_TAB_INDEX);
	}
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doCenterButtonTapped:(UIButton *)sender {
    
    //  Center button hides default middle tab so the button must simulate its tapping
    if([self.viewControllers count] >= CENTER_TAB_INDEX) {
        
        //  Center tabbar is already selected, pop navigation controller to the top
        if (self.selectedIndex == CENTER_TAB_INDEX) {
          //  [((UINavigationController *)self.viewControllers[CENTER_TAB_INDEX]) popToRootViewControllerAnimated:YES];
        }
        //  Else selected center tab
        else {
            self.selectedIndex = CENTER_TAB_INDEX;
        }
    }
}

@end
