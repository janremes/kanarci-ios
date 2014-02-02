/**

 Created by Mugunth Kumar on 21/03/11. Customized by Martin Dohnal.
 Copyright 2011 Steinlogic All rights reserved.

 */

#import "NSObject+MKBlockAdditions.h"

@implementation NSObject (MKBlockAdditions)

- (void)performBlockAction:(VoidBlock)block {
	if (block != nil){
		block();
	}
}

- (void)performBlock:(VoidBlock)block afterDelay:(NSTimeInterval)delay{
	VoidBlock blockCopy = [block copy];

	[self performSelector:@selector(performBlockAction:) withObject:blockCopy afterDelay:delay];

#if !__has_feature(objc_arc)
		[blockCopy autorelease];
#endif
}

- (void) performBlock:(VoidBlock)block{
	VoidBlock blockCopy = [block copy];

	[self performSelector:@selector(performBlockAction:) withObject:blockCopy];

#if !__has_feature(objc_arc)
		[blockCopy autorelease];
#endif
}

@end
