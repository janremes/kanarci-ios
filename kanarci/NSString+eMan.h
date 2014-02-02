/**
 
 Utility class for NSString
 
 Created by Martin Dohnal.
 Copyright (c) 2012 eMan s.r.o. All rights reserved.
 
 */

#import <Foundation/Foundation.h>

@interface NSString (eMan)

/**
 Compares two strings
 @param inA string or nil
 @param inB string or nil
 @returns YES if string content is the same (nil == "", "abc" == "abc")
 */
+(BOOL) stringContent:(NSString*)inA equalsToStringContent:(NSString*)inB;

/**
 Returns string from bundle resource file decoded using UTF-8 encoding.
 
 @param inResourceName resource file name
 @param inType resource file extension
 @return string from bundle resource file decoded using UTF-8 encoding.
 */
+(NSString*) stringFromBundleResource:(NSString*)inResourceName ofType:(NSString*)inType;

/**
 Checks string against a given regex.
 
 @param inRegEx regex to check
 @return YES if string matches regex
 */
-(BOOL) matchesRegex:(NSString*)inRegEx;

/**
 Checks if string contains given string.
 
 @param inString string to check
 @return YES if this string contains string in parameter.
 */
-(BOOL) containsString:(NSString*)inString;

#pragma mark - URL and HTML manipulation

/**
 Strips html tags from HTML (very slow implementation!).
 
 @return string stripped of HTML tags
 */
-(NSString*) stringByStrippingHTML;

/**
 Returns unescaped string from URL percent escaped string using NSUTF8 encoding
 @returns unescaped string
 */
-(NSString*) stringByUnescapingURLPercentEscapedString;


/// URL percent escaped string using NSUTF8 encoding
-(NSString*) URLPercentEscapedString;


#pragma mark -

@end
