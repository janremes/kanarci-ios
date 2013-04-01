//
//  KNTabBarCenterButton.h
//  kanarci
//
//  Created by Jan Remes on 28.03.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KNTabBarCenterButton : UIButton


@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, strong) UIImage *highlightedImage;

@property (nonatomic, strong) UIColor *normalBackgroundColor;
@property (nonatomic, strong) UIColor *highlightedBackgroundColor;

@property (nonatomic, copy) NSString *titleText;

@property (nonatomic, assign) BOOL highlightedStyle;

@end
