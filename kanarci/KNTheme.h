//
//  LMTheme.h
//  Lamaica
//
//  Created by Lukas Kukacka on 1/7/13.
//  Copyright (c) 2013 Fuerte International Ltd. All rights reserved.
//
//  Theme related settings

#import <Foundation/Foundation.h>

#define Theme KNTheme

#define HUD_DEFAULT_DELAY   2.0

#define DefaultCellImageSize    46

@interface KNTheme : NSObject

+ (UIFont *)appFontOfSize:(CGFloat)size;

+ (UIFont *)boldAppFontOfSize:(CGFloat)size;

+ (CGFloat)bigTextSize;

+ (CGFloat)sectionTitleSize;

+ (CGFloat)smallTextSize;

+ (CGFloat)defaultControlsTextSize;

+ (CGFloat)defaultCornerRadius;

+ (CGFloat)defaultBorderWidth;

+ (CGFloat)defaultContentMargin;    // distance of content from screen bounds
+ (CGFloat)defaultContentPadding;   // distance of content of the container from the bounds

//  Colors
+ (UIColor *)defaultBackgroundColor;    // background of all views
+ (UIColor *)defaultForegroundColor;    // foreground (cell color, view color - white in design)
+ (UIColor *)defaultBorderColor;

+ (UIColor *)defaultTextColor;

+ (UIColor *)defaultControlsTextColor;

+ (UIColor *)lightTextColor;

+ (UIColor *)mediumTextColor;

+ (UIColor *)darkenTextColor;

+ (UIColor *)activeColor;   // active color of theme (red)
+ (UIColor *)inactiveColor; // inactive color of theme (gray)

+ (UIColor *)cellImageBorderColor;

+ (UIColor *)cellDefaultColor;

+ (UIColor *)cellSelectedColor;

@end
