//
//  AppDelegate.m
//  kanarci
//
//  Created by Jan Remes on 10.03.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import "AppDelegate.h"
#import "KNDataManager.h"
#import "KNUserService.h"
#import "KNNavigationBar.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    



    
    //Initialize data manager
    [KNDataManager sharedInstance];
    
    //Initialize user data
    [KNUserService sharedInstance];
    
    [self customizeAppearance];
    

     UITabBarController *tabBar = (UITabBarController *)self.window.rootViewController;
    tabBar.selectedIndex = 2;

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
    
    
	//  Customize bar button items - normal state
	[[UIBarButtonItem appearance] setTitleTextAttributes:@{
                               NSForegroundColorAttributeName : [Theme defaultTextColor],
                                    NSFontAttributeName : [Theme boldAppFontOfSize:[Theme defaultControlsTextSize]]
     }
	                                            forState:UIControlStateNormal];
    
	//  Customize bar button items - highlighted state
	[[UIBarButtonItem appearance] setTitleTextAttributes:@{
                               NSForegroundColorAttributeName : [UIColor whiteColor],
     }
	                                            forState:UIControlStateHighlighted];
    
    //  Customize bar button items - disabled state
	[[UIBarButtonItem appearance] setTitleTextAttributes:@{
                               NSForegroundColorAttributeName : [Theme lightTextColor],
     }
	                                            forState:UIControlStateDisabled];

	//  Set text
	NSDictionary *textAttributes = @{
                                  NSFontAttributeName : [Theme boldAppFontOfSize:[Theme defaultControlsTextSize]],
                                  NSForegroundColorAttributeName : RGBCOLOR(74.0f, 74.0f, 74.0f),
                                  };
    
	[[UITabBarItem appearance] setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
       

}

@end
