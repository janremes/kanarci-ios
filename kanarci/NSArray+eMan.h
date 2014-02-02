/**
 
 Utility category for NSArray
 
 Created by Martin Dohnal.
 Copyright (c) 2012 eMan s.r.o. All rights reserved.
 
 */

#import <Foundation/Foundation.h>

@interface NSArray (eMan)

/**
 @return first object of the array or nil if array is empty
 */
-(id) firstObject;

/**
 Creates new array with replaced object inOld with new object inNew
 
 @param inOld object to be replaced
 @param inNew replacement (new) object
 @return new array
 */
-(NSArray*) arrayByReplacingObject:(id)inOld withObject:(id)inNew;

/**
 Creates new array with removed object inObject
 
 @param inObject object to remove
 @return new array
 */
-(NSArray*) arrayByRemovingObject:(id)inObject;

/**
 Traverses through array in attempt to find object at given index path
 @param indexPath indexpath with any length
 @return object or nil if not path was not found
 */
- (id)objectAtIndexPath:(NSIndexPath *)indexPath;


@end
