/**
 
 Utility category for UINavigationController
 
 Created by Martin Dohnal.
 Copyright (c) 2013 eMan s.r.o. All rights reserved.
 
 */

#import <UIKit/UIKit.h>

@interface UINavigationController (eMan)

/**
 Gets index in navigation stack of view controller with given class (first occurence from root controller).
 
 @param inClass class of view controller
 */
-(NSInteger) firstIndexOfViewControllerClass:(Class)inClass;

/**
 Pushes view controller by animated fading in from transparency
 
 @param inVC view controller to push
 */
- (void)pushViewControllerByFadingIn:(UIViewController *)inVC;

/**
 Pops top view controller by animated fading out to transparency
 */
- (void)popViewControllerByFadingOut;

@end
