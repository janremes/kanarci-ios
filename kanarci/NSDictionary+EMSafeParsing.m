/**
 
 Safe parsing for dictionary and base classes.
 
 Created by Martin Dohnal on 20.07.13.
 Copyright (c) 2013 eMan s.r.o. All rights reserved.
 
 */

#import "NSDictionary+EMSafeParsing.h"

@implementation NSDictionary (EMSafeParsing)

- (id)valueForKey:(NSString *)key ifKindOf:(Class)inClass defaultValue:(id)defaultValue
{
    id obj = [self objectForKey:key];
    return [obj isKindOfClass:inClass] ? obj : defaultValue;
}

-(NSString*) stringOrNilForKey:(NSString*)inKey
{
	return [self valueForKey:inKey ifKindOf:[NSString class] defaultValue:nil];
}

-(NSNumber*) numberOrNilForKey:(NSString*)inKey
{
	return [self valueForKey:inKey ifKindOf:[NSNumber class] defaultValue:nil];
}

-(NSDictionary*) dictionaryOrNilForKey:(NSString*)inKey
{
	return [self valueForKey:inKey ifKindOf:[NSDictionary class] defaultValue:nil];
}

-(NSArray*) arrayOrNilForKey:(NSString*)inKey
{
	return [self valueForKey:inKey ifKindOf:[NSArray class] defaultValue:nil];
}

@end
