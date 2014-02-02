/**
 
 Created by Martin Dohnal.
 Copyright (c) 2013 eMan s.r.o. All rights reserved.
 
 */

#import "UINavigationController+eMan.h"
#import <QuartzCore/QuartzCore.h>

@implementation UINavigationController (eMan)

-(NSInteger) firstIndexOfViewControllerClass:(Class)inClass{
	NSInteger index = 0;
	for(UIViewController* vc in self.viewControllers){
		if([vc isKindOfClass:inClass]){
			return index;
		}
		index++;
	}
	
	return NSNotFound;
}

- (void)pushViewControllerByFadingIn:(UIViewController *)inVC{
	
	CATransition *transition = [CATransition animation];
	transition.duration = 0.3f;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	transition.type = kCATransitionFade;
	
	[self.view.layer addAnimation:transition forKey:nil];
	[self pushViewController:inVC animated:NO];
}

- (void)popViewControllerByFadingOut{
	
	CATransition *transition = [CATransition animation];
	transition.duration = 0.3f;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	transition.type = kCATransitionFade;
	
	[self.view.layer addAnimation:transition forKey:nil];
	[self popViewControllerAnimated:NO];
}

@end
