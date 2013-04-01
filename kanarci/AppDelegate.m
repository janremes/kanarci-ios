//
//  AppDelegate.m
//  kanarci
//
//  Created by Jan Remes on 10.03.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import "AppDelegate.h"
#import "KNDataManager.h"
#import "KNUser.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    
    
    //Initialize data manager
    [KNDataManager sharedInstance];
    
    //Initialize user data
    [KNUser sharedInstance];
    
    // Select the center tab of our initial tab bar controller:
    UITabBarController *tabBar = (UITabBarController *)self.window.rootViewController;
    tabBar.selectedIndex = 1;
    
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)customizeAppearance {
    
	//  Customize navigation bar
	// Customize the title text for *all* UINavigationBars
	[[UINavigationBar appearance] setTitleTextAttributes:@{
                               UITextAttributeTextColor : [Theme defaultTextColor],
                         UITextAttributeTextShadowColor : [UIColor clearColor],
                                    UITextAttributeFont : [Theme boldAppFontOfSize:20.0]}];
    
	//  Custom navigation bar background
	[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navbar_bg"] forBarMetrics:UIBarMetricsDefault];
    
   
    
    
	//  Customize bar button items - normal state
	[[UIBarButtonItem appearance] setTitleTextAttributes:@{
                               UITextAttributeTextColor : [Theme defaultTextColor],
                         UITextAttributeTextShadowColor : [UIColor clearColor],
                                    UITextAttributeFont : [Theme boldAppFontOfSize:[Theme defaultControlsTextSize]]
     }
	                                            forState:UIControlStateNormal];
    
	//  Customize bar button items - highlighted state
	[[UIBarButtonItem appearance] setTitleTextAttributes:@{
                               UITextAttributeTextColor : [UIColor whiteColor],
                         UITextAttributeTextShadowColor : [UIColor clearColor]
     }
	                                            forState:UIControlStateHighlighted];
    
    //  Customize bar button items - disabled state
	[[UIBarButtonItem appearance] setTitleTextAttributes:@{
                               UITextAttributeTextColor : [Theme lightTextColor],
                         UITextAttributeTextShadowColor : [UIColor clearColor]
     }
	                                            forState:UIControlStateDisabled];
    
    
//	//  Bar button item
//	UIImage *barButtonBg = [[UIImage imageNamed:@"lam_btn_navbar_button"]
//                            resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
//	[[UIBarButtonItem appearance] setBackgroundImage:barButtonBg
//	                                        forState:UIControlStateNormal
//			                              barMetrics:UIBarMetricsDefault];
//    
//	//  Back button
//	UIImage *barBackButtonBg = [[UIImage imageNamed:@"lam_btn_navbar_back"]
//                                resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 5)];
//	[[UIBarButtonItem appearance] setBackButtonBackgroundImage:barBackButtonBg
//	                                                  forState:UIControlStateNormal
//			                                        barMetrics:UIBarMetricsDefault];
    
	//  Customize tab bar
//	UITabBar *tabBar = self.tabBarController.tabBar;
    
	// Set last tab item title
//	[[[tabBar items] lastObject] setTitle:NSLocalizedString(@"TAB_ACCOUNT", nil)];
    
	//  Set text
	NSDictionary *textAttributes = @{
                                  UITextAttributeFont : [Theme boldAppFontOfSize:[Theme defaultControlsTextSize]],
                                  UITextAttributeTextColor : RGBCOLOR(74.0f, 74.0f, 74.0f),
                                  UITextAttributeTextShadowColor : [UIColor clearColor]
                                  };
    
	[[UITabBarItem appearance] setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    
	/* [NSDictionary dictionaryWithObjectsAndKeys:
     [Theme boldAppFontOfSize: [Theme defaultControlsTextSize]], UITextAttributeFont,
     RGBCOLOR(74, 74, 74), UITextAttributeTextColor,
     [UIColor clearColor], UITextAttributeTextShadowColor, nil]
     forState: UIControlStateNormal];*/
}

@end
