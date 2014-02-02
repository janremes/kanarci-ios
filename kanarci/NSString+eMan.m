/**
 
 Created by Martin Dohnal.
 Copyright (c) 2012 eMan s.r.o. All rights reserved.
 
 */

#import "NSString+eMan.h"

@implementation NSString (eMan)

+(BOOL) stringContent:(NSString*)inA equalsToStringContent:(NSString*)inB
{
	if([inA length] == 0 && [inB length] == 0){
		return YES;
	}
	else{
		return [inA isEqualToString:inB];
	}
}

+(NSString*) stringFromBundleResource:(NSString*)inResourceName ofType:(NSString*)inType{
	NSString* path = [[NSBundle mainBundle] pathForResource:inResourceName ofType:inType];
	return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
}

-(BOOL) matchesRegex:(NSString*)inRegEx{
	if ([inRegEx length] > 0){
		NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", inRegEx];
		return [test evaluateWithObject:self];
	}
	else{
		return NO;
	}
}

-(BOOL) containsString:(NSString*)inString{
	return [self rangeOfString:inString].location != NSNotFound;
}

#pragma mark - HTML manipulation

-(NSString*) stringByStrippingHTML
{
	NSRange r;
	NSMutableString* s = [self mutableCopy];
	while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound){
		[s replaceCharactersInRange:r withString:@""];
	}
	
#if !__has_feature(objc_arc)
	[s autorelease];
#endif
	
	return s;
}

-(NSString*) stringByUnescapingURLPercentEscapedString
{
	NSString* unescaped = [self stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    return [unescaped stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

-(NSString*) URLPercentEscapedString
{
	NSString* escaped = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)self, NULL, (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ", kCFStringEncodingUTF8));
	return escaped;
}

#pragma mark -

@end
