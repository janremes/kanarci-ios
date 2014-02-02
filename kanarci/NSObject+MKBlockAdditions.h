/**

 Block additions for NSObject

 Created by Mugunth Kumar on 21/03/11. Customized by Martin Dohnal.
 Copyright 2011 Steinlogic All rights reserved.

 */

#import <Foundation/Foundation.h>
#import "MKBlockAdditions.h"

@interface NSObject (MKBlockAdditions)

/**
 Performs given block.
 @param block block
 */
- (void) performBlock:(VoidBlock)block;

/**
 Performs given block after delay (non blocking on a thread which call this).
 @param block block
 @param delay delay in seconds
 */
- (void) performBlock:(VoidBlock)block afterDelay:(NSTimeInterval)delay;

@end
