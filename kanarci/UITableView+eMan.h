/**
 
 Utility category for UITableView
 
 Created by Martin Dohnal.
 Copyright (c) 2012 eMan s.r.o. All rights reserved.
 
 */

#import <UIKit/UIKit.h>


@interface UITableView (eMan)

/**
 Deselects all rows.
 @param inAnimated animated
 */
-(void) deselectAllRowsAnimated:(BOOL)inAnimated;

/**
 Removes blank rows by setting empty table header and footer views.
 */
-(void) disableBlankRows;

/**
 Scrolls to bottom of Table view
 @param inAnimated animated
 */
-(void) scrollToBottomAnimated:(BOOL)inAnimated;

/**
 Scrolls to bottom of Table view and call given block on completion.
 @param afterAnimationBlock block to call after animation ended
 */
-(void) scrollToBottomAnimatedWithBlock:(void(^)(UITableView* inTableView))afterAnimationBlock;

@end
