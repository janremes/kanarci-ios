//
//  KNUIFactory.m
//  kanarci
//
//  Created by Jan Remes on 23.03.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import "KNUIFactory.h"
#import <QuartzCore/QuartzCore.h>

@implementation KNUIFactory


+(void) setupMenuButon:(UIButton *) button {

    
    UIImage *whiteImage = [self imageFromColorButton:[UIColor whiteColor]];
    UIImage *yellowImage = [self imageFromColorButton:[UIColor colorWithRed:255.0/255.0 green:244.0/255.0 blue:101.0/255.0 alpha:1.0]];
    [button setBackgroundImage:whiteImage forState:UIControlStateNormal];
    [button setBackgroundImage:yellowImage forState:UIControlStateHighlighted];

    button.layer.masksToBounds = NO;
    button.layer.shadowColor = [UIColor blackColor].CGColor;
    button.layer.shadowRadius = 6.0f;
    button.layer.shadowOpacity = 0.6f;
    button.layer.shadowOffset = CGSizeMake(0, 0);

    [button setAdjustsImageWhenHighlighted:NO];
    
    

}



+ (UILabel *)labelWithFontSize:(CGFloat)size bold:(BOOL)bold
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 12)];
    label.backgroundColor = [UIColor clearColor];
    label.font = (bold ? [Theme boldAppFontOfSize:size] : [Theme appFontOfSize:size]);
    label.numberOfLines = 1;
    label.textColor = [UIColor blackColor];
    label.textAlignment = UITextAlignmentLeft;
    label.lineBreakMode = UILineBreakModeTailTruncation;
    label.adjustsFontSizeToFitWidth = YES;
    label.minimumFontSize = size/1.3;
    
    return label;
}


+ (UISegmentedControl *)segmentedControlWithItems:(NSArray *)items {
	//  Create segmented control
	UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:items];
    
    segment.layer.shadowColor = [UIColor blackColor].CGColor;
    segment.layer.shadowOpacity = 0.3;
    segment.layer.shadowRadius = 5;
    segment.layer.shadowOffset = CGSizeMake(0.0f, 4.0f);
    
	//  Set custom font
	UIFont *font = [Theme boldAppFontOfSize:12.0];
	NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, UITextAttributeFont,
                                [UIColor blackColor], UITextAttributeTextColor,
                                [UIColor clearColor], UITextAttributeTextShadowColor,
                                nil];
	[segment setTitleTextAttributes:attributes
	                       forState:UIControlStateNormal];
    
    
//    for (UIView *view in segment.subviews) {
//        view.layer.shadowColor = [UIColor blackColor].CGColor;
//        view.layer.shadowOpacity = 0.3;
//        view.layer.shadowRadius = 4;
//        view.layer.shadowOffset = CGSizeMake(-4.0f, 0.0f);
//    }
    
	//  Customize background
	UIImage *activeImage =  [UIImage imageNamed:@"kn_control_active"];
	UIImage *inactiveImage = [UIImage imageNamed:@"kn_control_passive"];
//	UIImage *spaceImage = [[self class] imageFromColor:[UIColor clearColor]];
    UIImage *selUnselImage = [UIImage imageNamed:@"kn_control__sel_unsel"];
    UIImage *unselSselImage = [UIImage imageNamed:@"kn_control__unsel_sel"];
     UIImage *unselSUnselImage = [UIImage imageNamed:@"kn_control_unsel_unsel"];
	//  Background of segments
	[segment setBackgroundImage:inactiveImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
	[segment setBackgroundImage:activeImage forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    
    
    //  Spacing images
//	[segment setDividerImage:spaceImage
//	     forLeftSegmentState:UIControlStateNormal
//		   rightSegmentState:UIControlStateNormal
//				  barMetrics:UIBarMetricsDefault];
//	[segment setDividerImage:spaceImage
//	     forLeftSegmentState:UIControlStateSelected
//		   rightSegmentState:UIControlStateNormal
//				  barMetrics:UIBarMetricsDefault];
//	[segment setDividerImage:spaceImage
//	     forLeftSegmentState:UIControlStateNormal
//		   rightSegmentState:UIControlStateSelected
//				  barMetrics:UIBarMetricsDefault];
    
	//  Spacing images
	[segment setDividerImage:unselSUnselImage
	     forLeftSegmentState:UIControlStateNormal
		   rightSegmentState:UIControlStateNormal
				  barMetrics:UIBarMetricsDefault];
	[segment setDividerImage:selUnselImage
	     forLeftSegmentState:UIControlStateSelected
		   rightSegmentState:UIControlStateNormal
				  barMetrics:UIBarMetricsDefault];
	[segment setDividerImage:unselSselImage
	     forLeftSegmentState:UIControlStateNormal
		   rightSegmentState:UIControlStateSelected
				  barMetrics:UIBarMetricsDefault];
    
	return segment;
}



#pragma mark Utils
+ (UIImage *)imageFromColor:(UIColor *)color {
    
	CGRect rect = CGRectMake(0, 0, 1, 1);
	UIGraphicsBeginImageContext(rect.size);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, [color CGColor]);
	CGContextFillRect(context, rect);
	UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return img;
}


+ (UIImage *)imageFromColorButton:(UIColor *)color {
    
	CGRect rect = CGRectMake(0, 0, 150, 40);
	UIGraphicsBeginImageContext(rect.size);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, [color CGColor]);
	CGContextFillRect(context, rect);
	UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return img;
}

@end
