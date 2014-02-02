/**
 
 Utility class to UIScrollView
 
 Created by Martin Dohnal.
 Copyright (c) 2012 eMan s.r.o. All rights reserved.
 
 */

#import <UIKit/UIKit.h>

@interface UIScrollView (eMan)

/**
 Scrolls to left
 @param inAnimated animated
 */
-(void) scrollToLeftAnimated:(BOOL)inAnimated;

/**
 Scrolls to top
 @param inAnimated animated
 */
-(void) scrollToTopAnimated:(BOOL)inAnimated;

/**
 Scrolls to bottom
 @param inAnimated animated
 */
-(void) scrollToBottomAnimated:(BOOL)inAnimated;

/**
 Scrolls to right
 @param inAnimated animated
 */
-(void) scrollToRightAnimated:(BOOL)inAnimated;

/**
 * Recognizes if the scrollview changed page
 * and returns it (use only with pagingEnabled=YES)
 *
 * @return NSInteger
 */
- (NSInteger) currentPage;

@end
