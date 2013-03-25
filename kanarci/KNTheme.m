//
//  LMTheme.m
//  Lamaica
//
//  Created by Lukas Kukacka on 1/7/13.
//  Copyright (c) 2013 Fuerte International Ltd. All rights reserved.
//

#import "KNTheme.h"

@implementation KNTheme

+ (UIFont *)appFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:size];;
}

+ (UIFont *)boldAppFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:@"HelveticaNeue-Medium" size:size];
}

+ (CGFloat)bigTextSize {
    return 18;
}

+ (CGFloat)sectionTitleSize {
    return 16;
}

+ (CGFloat)smallTextSize
{
    return 11;
}

+ (CGFloat)defaultControlsTextSize
{
    return 11.0f;
}

+ (CGFloat)defaultCornerRadius {
    return 4.0f;
}

+ (CGFloat)defaultBorderWidth {
    return 1.0f;
}

+ (CGFloat)defaultContentMargin {
    return 10.0f;
}

+ (CGFloat)defaultContentPadding {
    return 20;
}

#pragma mark Colors
+ (UIColor *)defaultBackgroundColor {
    return RGBCOLOR(220, 220, 220);
}

+ (UIColor *)defaultForegroundColor {
    return [UIColor whiteColor];
}

+ (UIColor *)defaultBorderColor {
    return RGBCOLOR(209, 209, 209);
}

+ (UIColor *)defaultTextColor {
    return [UIColor darkTextColor];
}

+ (UIColor *)defaultControlsTextColor {
    return [UIColor whiteColor];
}

+ (UIColor *)lightTextColor {
    return RGBCOLOR(172, 172, 172);
}

+ (UIColor *)mediumTextColor {
    return RGBCOLOR(153, 153, 153);
}

+ (UIColor *)darkenTextColor {
    return RGBCOLOR(102, 102, 102);
}

+ (UIColor *)activeColor {
    return RGBCOLOR(217, 94, 73);
}
+ (UIColor *)inactiveColor {
    return RGBCOLOR(172, 172, 172);
}

+ (UIColor *)cellImageBorderColor {
    return RGBCOLOR(209, 209, 209);
}

+ (UIColor *)cellDefaultColor {
    return [UIColor whiteColor];
}
+ (UIColor *)cellSelectedColor {
    return RGBCOLOR(234, 234, 234);
}

@end
