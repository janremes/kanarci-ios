/**
 
 Safe typed parsing methods for NSDictionary
 Partially from: http://www.stewgleadow.com/blog/2012/05/18/tolerant-json-parsing-for-ios/
 
 Created by Martin Dohnal on 20.07.13.
 Copyright (c) 2013 eMan s.r.o. All rights reserved.
 
 */

#import <Foundation/Foundation.h>

@interface NSDictionary (EMSafeParsing)

/**
 Returns value for a given key of given type
 @param key dictionary key
 @param inClass expected type
 @param defaultValue default value if value was not found or type was different
 @returns value with given type, or default value
 */
- (id)valueForKey:(NSString *)key ifKindOf:(Class)inClass defaultValue:(id)defaultValue;

/**
 Returns string or nil for a given key
 @param inKey dictionary key
 @returns string or nil
 */
-(NSString*) stringOrNilForKey:(NSString*)inKey;

/**
 Returns number or nil for a given key
 @param inKey dictionary key
 @returns number or nil
 */
-(NSNumber*) numberOrNilForKey:(NSString*)inKey;

/**
 Returns dictionary or nil for a given key
 @param inKey dictionary key
 @returns dictionary or nil
 */
-(NSDictionary*) dictionaryOrNilForKey:(NSString*)inKey;

/**
 Returns array or nil for a given key
 @param inKey dictionary key
 @returns array or nil
 */
-(NSArray*) arrayOrNilForKey:(NSString*)inKey;

@end
