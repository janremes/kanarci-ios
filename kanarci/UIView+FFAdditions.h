///
/// UIView(FFAdditions)
/// Footfall123
///
/// Created by matthes on 19.12.12.
/// Copyright (c) 2012. All rights reserved.
///
#import <Foundation/Foundation.h>

typedef enum {
	FFViewAlignmentTop = 2,
	FFViewAlignmentLeft = 4,
	FFViewAlignmentBottom = 8,
	FFViewAlignmentRight = 16,
	FFViewAlignmentCenter = 32

} FFViewAlignment;

@interface UIView (FFAdditions)

/*!
 @abstract Shortcut for frame.origin.x.
 @discussion Sets frame.origin.x = left
 */
@property(nonatomic) CGFloat left;

/*!
 @abstract Shortcut for frame.origin.y
 @discussion Sets frame.origin.y = top
 */
@property(nonatomic) CGFloat top;

/*!
 @abstract  Shortcut for frame.origin.x + frame.size.width
 @discussion Sets frame.origin.x = right - frame.size.width
 */
@property(nonatomic) CGFloat right;

/*!
 @abstract Shortcut for frame.origin.y + frame.size.height
 @discussion Sets frame.origin.y = bottom - frame.size.height
 */
@property(nonatomic) CGFloat bottom;


/*!
 @abstract Returns distance of bottom border from superviews bottom border
 @discussion Sets the distance of view's bottom border from superview's bottom border
 */
@property(nonatomic) CGFloat bottomMargin;

/*!
 @abstract Returns the distance of the view's right border from the superview'ss right border
 @discussion Sets the distance of view's right border from the superview's right border
 */
@property(nonatomic) CGFloat rightMargin;

/*!
 @abstract Shortcut for frame.size.width
 @discussion Sets frame.size.width = width
 */
@property(nonatomic) CGFloat width;

/*!
 @abstract Shortcut for frame.size.height
 @discussion Sets frame.size.height = height
 */
@property(nonatomic) CGFloat height;

/*!
 @abstract  Shortcut for center.x
 @discussion Sets center.x = centerX
 */
@property(nonatomic) CGFloat centerX;

/*!
 @abstract Shortcut for center.y
 @discussion Sets center.y = centerY
 */
@property(nonatomic) CGFloat centerY;

/*!
 @abstract Shortcut for frame.origin
 */
@property(nonatomic) CGPoint origin;

/*!
 @abstract Shortcut for frame.size
 */
@property(nonatomic) CGSize size;

/*!
 @abstract Center point of the bounds rect
 */
@property(nonatomic, readonly) CGPoint boundsCenter;

/*!
 @abstract Return the width in portrait or the height in landscape.
 */
@property(nonatomic, readonly) CGFloat orientationWidth;

/*!
 @abstract Return the height in portrait or the width in landscape.
 */
@property(nonatomic, readonly) CGFloat orientationHeight;

/*!
 @abstract Shrinks view's size by values in size parameter
 */
- (void)shrinkBySize:(CGSize)size;

/*!
 @abstract Stretches view's size by values in size parameter
 */
- (void)stretchBySize:(CGSize)size;

/*!
 @abstract Aligns with otherView according to value specified in alignmentMask parameter.
 @discussion Typically, alignmentMask bitmask contains two values for horizontal and vertical alignment.
 FFViewAlignmentTop and FFViewAlignmentBottom are mutually exclusive. The same applies for vertical alignment values.
 */
- (void)alignWithView:(UIView *)otherView alignmentMask:(FFViewAlignment)alignmentMask;

/*!
 @abstract Removes all subviews.
 */
- (void)removeAllSubviews;

//  Centers in superview to axes
- (void)centerInSuperview;

- (void)centerVertically;

- (void)centerHorizontally;

//  MACROS
//  All flexible autoresizing margins
#define UIViewAutoresizingFlexibleAllMargins (UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin)

//  Flexible width and height
#define UIViewAutoresizingFlexibleSize  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight


@end
