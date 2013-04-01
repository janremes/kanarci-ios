//
//  KNTabBarCenterButton.m
//  kanarci
//
//  Created by Jan Remes on 28.03.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import "KNTabBarCenterButton.h"
#import <QuartzCore/QuartzCore.h>
#import "KNUIFactory.h"

@implementation KNTabBarCenterButton {
    UIImageView *_imageView;
    
    UILabel *_label;
}
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initializeView];
    }
    return self;
}

+ (Class)layerClass {
    
    return [CAShapeLayer class];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Accessors
- (void)setTitleText:(NSString *)titleText {
    
    _titleText = [titleText copy];
    
    _label.text = _titleText;
}

- (void)setHighlightedStyle:(BOOL)highlightedStyle {
    
    _highlightedStyle = highlightedStyle;
    
    [self configureForCurrentState];
}

- (void)setNormalImage:(UIImage *)normalImage {
    
    _normalImage = normalImage;
    
    [self configureForCurrentState];
}

- (void)setHighlightedImage:(UIImage *)highlightedImage {
    
    _highlightedImage = highlightedImage;
    
    [self configureForCurrentState];
}

- (void)setNormalBackgroundColor:(UIColor *)normalBackgroundColor {
    
    _normalBackgroundColor = normalBackgroundColor;
    
    [self configureForCurrentState];
}

- (void)setHighlightedBackgroundColor:(UIColor *)highlightedBackgroundColor {
    
    _highlightedBackgroundColor = highlightedBackgroundColor;
    
    [self configureForCurrentState];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Overrides
- (void)setFrame:(CGRect)frame {
    
    [super setFrame:frame];
    
    [self createRoundedCorners];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Private interface
- (void)initializeView {
    
    //  Configure
    [self configureForCurrentState];
    
    [self createRoundedCorners];
    
    //  Create dropped shadow of the button
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.3f;
    self.layer.shadowRadius = 4.0f;
    self.layer.shadowOffset = CGSizeMake(0, 3.0f);
    self.layer.masksToBounds = NO;
    
    //  Create image view for the icon
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    _imageView.contentMode = UIViewContentModeCenter;
    [self addSubview:_imageView];
    
    //  Create label fot the title text
    _label = [KNUIFactory labelWithFontSize:10 bold:NO];
    [_label setTextColor:[UIColor whiteColor]];
    [_label setFont:[UIFont boldSystemFontOfSize:10.0]];
    _label.textAlignment = UITextAlignmentCenter;
    
    
   // [_label setBackgroundColor:[UIColor blackColor]];
    
    [self addSubview:_label];
}

- (void)layoutSubviews {
    
    //  Position the title label
    _label.left = 3;
    _label.width = self.width - 6;
    _label.height = 12;
    _label.bottomMargin = 3;
    
    //  Icon image view
    _imageView.bottomMargin = _label.bottomMargin + _label.height + 1 +6;
    [_imageView centerHorizontally];
}

- (void)configureForCurrentState {
    
    UIColor *backgroundColor = nil;
    UIImage *image = nil;
    
    if(self.highlightedStyle) {
        backgroundColor = _highlightedBackgroundColor;
        image = _highlightedImage;
    }
    else {
        backgroundColor = _normalBackgroundColor;
        image = _normalImage;
    }
    
//    //  Reconfigure layer
//    CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
//    shapeLayer.fillColor = backgroundColor.CGColor;
    
    //  Configure image view
    _imageView.image = image;
}

- (void) createRoundedCorners {
    
//	//  Create rounded borders depending on state
	CGFloat cornerRadius = 4;
	CGFloat bottomRadius = 0;
    
	CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
//
    
//    CALayer *layer = self.layer;
//    CGFloat radius = 10.0;
//    
//    [layer setMasksToBounds:YES];
//    [layer setCornerRadius:radius ];
//    [layer setBackgroundColor:[[UIColor blackColor] CGColor]];
//    [layer setBounds:CGRectMake(0.0f, 0.0f, radius *2 ,radius *2)];
    
    
	//  Create path manually
	//  The path to be animable must have same number of control points which can be done using bezier path
	CGMutablePathRef path = CGPathCreateMutable();
    
	//  Calculate positions of the rounded rect path
	CGRect frame = self.bounds;
	CGFloat left = frame.origin.x;
	CGFloat top = frame.origin.y + 15;
	CGFloat bottom = self.frame.size.height;
	CGFloat right = left + frame.size.width;
    
    CGFloat centerRadius = 24.0;
    CGFloat centerArc = left + frame.size.width/2;
    
	//  Contruct the path, starting at the bottom left corner and going clockwise
	CGPathMoveToPoint(path, NULL, left, bottom - bottomRadius);
	CGPathAddArc(path, NULL, left , top, 0, M_PI, -M_PI_2, NO);
    
    CGPathAddArc(path, NULL, centerArc , top, centerRadius, M_PI, -M_PI, NO);
   // CGPathAddArc(path, NULL, left + 40 , top, 10, -M_PI_2,0 , NO);
    
	CGPathAddArc(path, NULL, right , top , 0, -M_PI_2, 0, NO);
	CGPathAddArc(path, NULL, right - bottomRadius, bottom - bottomRadius, bottomRadius, 0, M_PI_2, NO);
	CGPathAddArc(path, NULL, left + bottomRadius, bottom - bottomRadius, bottomRadius, M_PI_2, M_PI, NO);
    
	//  MUST set the path to the property even if the animation is stared
	//  Not doing so causes the path to animate and return back to the original state
	shapeLayer.path = path;
    
	CGPathRelease(path);
}

@end

