///
/// UIView(FFAdditions)
/// Footfall123
///
/// Created by matthes on 19.12.12.
/// Copyright (c) 2012. All rights reserved.
///
#import "UIView+FFAdditions.h"


@implementation UIView (FFAdditions)

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Properties

- (CGFloat) left {

	return self.frame.origin.x;
}

- (void) setLeft: (CGFloat) x {

	CGRect frame = self.frame;
	frame.origin.x = x;
	self.frame = frame;
}

- (CGFloat) top {

	return self.frame.origin.y;
}


- (void) setTop: (CGFloat) y {

	CGRect frame = self.frame;
	frame.origin.y = y;
	self.frame = frame;
}

- (CGFloat) right {

	return self.frame.origin.x + self.frame.size.width;
}

- (void) setRight: (CGFloat) right {

	CGRect frame = self.frame;
	frame.origin.x = right - frame.size.width;
	self.frame = frame;
}

- (CGFloat) bottom {

	return self.frame.origin.y + self.frame.size.height;
}

- (void) setBottom: (CGFloat) bottom {

	CGRect frame = self.frame;
	frame.origin.y = bottom - frame.size.height;
	self.frame = frame;
}

- (CGFloat)bottomMargin
{
    if(self.superview) {
        return self.superview.height - self.bottom;
    }
    return 0;
}

- (void)setBottomMargin:(CGFloat)bottomMargin
{
    if(self.superview) {
        CGRect frame = self.frame;
		frame.origin.y = self.superview.height - bottomMargin - self.height;
		self.frame = frame;
    }
}

- (CGFloat)rightMargin
{
	if (self.superview) {
		return self.superview.width - self.right;
	}
	return 0;
}

- (void)setRightMargin:(CGFloat)rightMargin
{
	if (self.superview) {
		CGRect frame = self.frame;
		frame.origin.x = self.superview.width - rightMargin - self.width;
		self.frame = frame;
	}
}

- (CGFloat) centerX {

	return self.center.x;
}

- (void) setCenterX: (CGFloat) centerX {

	self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat) centerY {

	return self.center.y;
}

- (void) setCenterY: (CGFloat) centerY {

	self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat) width {

	return self.frame.size.width;
}

- (void) setWidth: (CGFloat) width {

	CGRect frame = self.frame;
	frame.size.width = width;
	self.frame = frame;
}

- (CGFloat) height {

	return self.frame.size.height;
}

- (void) setHeight: (CGFloat) height {

	CGRect frame = self.frame;
	frame.size.height = height;
	self.frame = frame;
}

- (CGPoint) origin {

	return self.frame.origin;
}

- (void) setOrigin: (CGPoint) origin {

	CGRect frame = self.frame;
	frame.origin = origin;
	self.frame = frame;
}

- (CGSize) size {

	return self.frame.size;
}

- (CGPoint)boundsCenter
{
    return CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
}

- (void) setSize: (CGSize) size {

	CGRect frame = self.frame;
	frame.size = size;
	self.frame = frame;
}

- (CGFloat) orientationWidth {

	return UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) ? self.height : self.width;
}

- (CGFloat) orientationHeight {

	return UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) ? self.width : self.height;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public methods

- (void) shrinkBySize: (CGSize) size {

	CGSize currentSize = self.size;

	currentSize.width -= size.width;
	currentSize.height -= size.height;

	self.size = currentSize;
}

- (void) stretchBySize: (CGSize) size {

	CGSize currentSize = self.size;

	currentSize.width += size.width;
	currentSize.height += size.height;

	self.size = currentSize;
}

- (void) alignWithView: (UIView *) otherView alignmentMask: (FFViewAlignment) alignmentMask {

	if(alignmentMask & FFViewAlignmentCenter) {
		self.center = otherView.center;
	}

	/// Horizontal alignment
	if(alignmentMask & FFViewAlignmentTop) {
		self.top = otherView.top;
	}
	else if(alignmentMask & FFViewAlignmentBottom) {
		self.bottom = otherView.bottom;
	}

	/// Vertical alignment
	if(alignmentMask & FFViewAlignmentLeft) {
		self.left = otherView.left;
	}
	else if(alignmentMask & FFViewAlignmentRight) {
		self.right = otherView.right;
	}
}

- (void) removeAllSubviews {

	while(self.subviews.count) {
		UIView *child = self.subviews.lastObject;
		[child removeFromSuperview];
	}
}

- (void)centerInSuperview
{
    if(self.superview) {
        self.center = CGPointMake(CGRectGetMidX(self.superview.bounds), CGRectGetMidY(self.superview.bounds));
    }
}

- (void)centerVertically
{
    if(self.superview) {
        self.center = CGPointMake(self.center.x, CGRectGetMidY(self.superview.bounds));
    }
}

- (void)centerHorizontally
{
    if(self.superview) {
        self.center = CGPointMake(CGRectGetMidX(self.superview.bounds), self.center.y);
    }
}

@end
