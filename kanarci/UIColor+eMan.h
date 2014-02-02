/**
 
 Utility class for UIColor
 
 Created by Daniel Honzik.
 Copyright (c) 2012 eMan s.r.o. All rights reserved.
 
 */

#import <Foundation/Foundation.h>

@interface UIColor (eMan)

/**
 Creates new color from hex string
 @param hexString hex string in formats #aabbcc, aabbcc, #aabbccdd, aabbccdd
 @return new UIColor
 */
+ (UIColor *) colorWithHexString:(NSString *)hexString;

/**
 @return rbg hex string in format #aabbcc
 */
- (NSString*) hexString24 NS_AVAILABLE_IOS(5_0);

/**
 @return rbga hex string in format #aabbccdd
 */
- (NSString*) hexString32 NS_AVAILABLE_IOS(5_0);

@end
