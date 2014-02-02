/**
 
 Created by Martin Dohnal.
 Copyright (c) 2012 eMan s.r.o. All rights reserved.
 
 */

#import "NSArray+eMan.h"

@implementation NSArray (eMan)

-(id) firstObject{
	return (([self count] > 0) ? [self objectAtIndex:0] : nil);
}

-(NSArray*) arrayByReplacingObject:(id)inOld withObject:(id)inNew{
	NSMutableArray* arr = [self mutableCopy];
	NSInteger index = [arr indexOfObject:inOld];
	
	if(index != NSNotFound){
		[arr replaceObjectAtIndex:index withObject:inNew];
	}

#if !__has_feature(objc_arc)
		[arr autorelease];
#endif

	return arr;
}

-(NSArray*) arrayByRemovingObject:(id)inObject{
	NSMutableArray* arr = [self mutableCopy];
	[arr removeObject:inObject];

#if !__has_feature(objc_arc)
		[arr autorelease];
#endif

	return arr;
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath
{
	if(indexPath.length == 0){
		return nil;
	}
	
	id obj = self;
	for(NSUInteger i = 0; i < indexPath.length; i++){
		NSUInteger pos = [indexPath indexAtPosition:i];
		if([obj isKindOfClass:[NSArray class]]){
			NSArray *objArray = obj;
			if (objArray.count > pos) {
				obj = [objArray objectAtIndex:pos];
			} else {
				obj = nil;
				break;
			}
		}
		else{
			obj = nil;
			break;
		}
	}
	
	return obj;
}

@end
