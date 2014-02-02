/**
 
 Created by Martin Dohnal.
 Copyright (c) 2012 eMan s.r.o. All rights reserved.
 
 */

#import "UIScrollView+eMan.h"

@implementation UIScrollView (eMan)

-(void) scrollToLeftAnimated:(BOOL)inAnimated{
	[self scrollRectToVisible:CGRectMake(0, self.contentOffset.y, 1, 1) animated:inAnimated];
}

-(void) scrollToTopAnimated:(BOOL)inAnimated{
	[self scrollRectToVisible:CGRectMake(self.contentOffset.x, 0, 1, 1) animated:inAnimated];
}

-(void) scrollToBottomAnimated:(BOOL)inAnimated{
	CGRect bottomRect = self.bounds;
	bottomRect = CGRectOffset(bottomRect, 0, fmaxf(0, self.contentSize.height - self.bounds.size.height));
	bottomRect.origin.x = self.contentOffset.x;
	[self scrollRectToVisible:bottomRect animated:inAnimated];
}

-(void) scrollToRightAnimated:(BOOL)inAnimated{
	CGRect rightRect = self.bounds;
	rightRect = CGRectOffset(rightRect, 0, fmaxf(0, self.contentSize.height - self.bounds.size.height));
	rightRect.origin.y = self.contentOffset.y;
	[self scrollRectToVisible:rightRect animated:inAnimated];
}

- (NSInteger) currentPage{
    return floor((self.contentOffset.x - self.frame.size.width / 2) / self.frame.size.width) + 1;
}

@end
