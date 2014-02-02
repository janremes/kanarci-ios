/**
 
 Created by Martin Dohnal.
 Copyright (c) 2012 eMan s.r.o. All rights reserved.
 
 */

#import "UIBarButtonItem+eMan.h"

@implementation UIBarButtonItem (eMan)

-(id) initWithImageNamed:(NSString*)inImageName target:(id)inTarget action:(SEL)inAction{
	return [self initWithImage:[UIImage imageNamed:inImageName] target:inTarget action:inAction];
}

-(id) initWithImage:(UIImage*)inImage target:(id)inTarget action:(SEL)inAction{
	UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
	[btn setImage:inImage forState:UIControlStateNormal];
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
	[btn addTarget:inTarget action:inAction forControlEvents:UIControlEventTouchUpInside];
	self = [self initWithCustomView:btn];
    

#if !__has_feature(objc_arc)
		[btn autorelease];
#endif

	return self;
}

-(id) initWithImageNamed:(NSString*)inImageName target:(id)inTarget action:(SEL)inAction imageInsets:(UIEdgeInsets) insets{
	return [self initWithImage:[UIImage imageNamed:inImageName] target:inTarget action:inAction imageInsets:insets];
}

-(id) initWithImage:(UIImage*)inImage target:(id)inTarget action:(SEL)inAction imageInsets:(UIEdgeInsets)insets{
	UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
	[btn setImage:inImage forState:UIControlStateNormal];
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btn setImageEdgeInsets:insets];
	[btn addTarget:inTarget action:inAction forControlEvents:UIControlEventTouchUpInside];
	self = [self initWithCustomView:btn];
    
#if !__has_feature(objc_arc)
    [btn autorelease];
#endif
    
	return self;
}


- (CGRect)frameInView:(UIView *)inView{
	UIView *originalCustomView = self.customView;
	
	UIView *tempView = nil;
	if(originalCustomView == nil){
		tempView = [[UIView alloc] initWithFrame:CGRectZero];
		self.customView = tempView;
	}
	
	UIView *parentView = self.customView.superview;
	NSUInteger indexOfView = [parentView.subviews indexOfObject:self.customView];
	
	if(tempView != nil){
		self.customView = originalCustomView;
	}

#if !__has_feature(objc_arc)
		[tempView release];
#endif
	
	UIView *buttonView = [parentView.subviews objectAtIndex:indexOfView];
	return [parentView convertRect:buttonView.frame toView:inView];
}

+(UIBarButtonItem*) fixedSpaceWithWidth:(CGFloat)inWidth{
	UIBarButtonItem* itm = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
	itm.width = inWidth;

#if !__has_feature(objc_arc)
		[itm autorelease];
#endif

	return itm;
}

@end
