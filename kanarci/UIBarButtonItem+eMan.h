/**
 
 Utility class for UIBarButtonItem
 
 Created by Martin Dohnal.
 Copyright (c) 2012 eMan s.r.o. All rights reserved.
 
 */

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (eMan)

-(id) initWithImageNamed:(NSString*)inImageName target:(id)inTarget action:(SEL)inAction;

-(id) initWithImage:(UIImage*)inImage target:(id)inTarget action:(SEL)inAction;

- (CGRect)frameInView:(UIView *)inView;

+(UIBarButtonItem*) fixedSpaceWithWidth:(CGFloat)inWidth;
-(id) initWithImage:(UIImage*)inImage target:(id)inTarget action:(SEL)inAction imageInsets:(UIEdgeInsets)insets;
-(id) initWithImageNamed:(NSString*)inImageName target:(id)inTarget action:(SEL)inAction imageInsets:(UIEdgeInsets) insets;
@end
