/**
 
 Created by Martin Dohnal.
 Copyright (c) 2012 eMan s.r.o. All rights reserved.
 
 */

#import "UITableView+eMan.h"

@implementation UITableView (eMan)

-(void) deselectAllRowsAnimated:(BOOL)inAnimated{
	NSArray* selectedRows = nil;
	if ([self respondsToSelector:@selector(indexPathsForSelectedRows)]){
		selectedRows = [self indexPathsForSelectedRows];
	}
	else{
		if([self indexPathForSelectedRow] != nil){
			selectedRows = @[[self indexPathForSelectedRow]];
		}
	}

	for(NSIndexPath* selIndex in selectedRows){
		[self deselectRowAtIndexPath:selIndex animated:inAnimated];
	}
}

-(void) disableBlankRows{
	UIView* emptyViewHeader = [[UIView alloc] initWithFrame:CGRectZero];
	self.tableHeaderView = emptyViewHeader;

	UIView* emptyViewFooter = [[UIView alloc] initWithFrame:CGRectZero];
	self.tableFooterView = emptyViewFooter;

#if !__has_feature(objc_arc)
		[emptyViewHeader autorelease];
		[emptyViewFooter autorelease];
#endif
	
}

-(void) scrollToBottomAnimated:(BOOL)inAnimated{
	CGRect bottomRect = self.bounds;
	bottomRect = CGRectOffset(bottomRect, 0, fmaxf(0, self.contentSize.height - self.bounds.size.height));
	[self scrollRectToVisible:bottomRect animated:inAnimated];
}

-(void) scrollToBottomAnimatedWithBlock:(void(^)(UITableView* inTableView))afterAnimationBlock{
	[UIView animateWithDuration:0.3f animations:^{
		[self setContentOffset: CGPointMake(0, fmaxf(0, self.contentSize.height-self.bounds.size.height))];
	} completion:^(BOOL finished) {
		if(afterAnimationBlock){
			afterAnimationBlock(self);
		}
	}];
}

@end
