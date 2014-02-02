/**
 
 NSData utility category.
 
 Hex conversion from http://stackoverflow.com/questions/2919649/map-nsstring-characters-to-nsdatahex
 
 Created by Martin Dohnal.
 Copyright (c) 2013 eMan s.r.o. All rights reserved.
 
 */

#import <Foundation/Foundation.h>

@interface NSData (eMan)

/**
 Creates data from a hexadecimal string.
 @param inString hexadecimal string
 @return data from a hexadecimal string
 */
+(NSData*) dataWithHexaString:(NSString*)inString;

/**
 @return hexadecimal string from data
 */
-(NSString*) hexaString;

@end
