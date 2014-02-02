/**
 
 Created by Daniel Honzik.
 Copyright (c) 2012 eMan s.r.o. All rights reserved.
 
 */

#import "UIColor+eMan.h"

@implementation UIColor(eMan)

#define ALMOST_256 255.99999f

+(UIColor *) colorWithHexString:(NSString *)hexString {
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
	
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

-(NSString*) hexString24 NS_AVAILABLE_IOS(5_0){
	if([self respondsToSelector:@selector(getRed:green:blue:alpha:)] == NO){
		return nil;
	}
	
	float r,g,b,a;
	[self getRed:&r green:&g blue:&b alpha:&a];
	return [NSString stringWithFormat:@"#%02x%02x%02x",
			(int) (r * ALMOST_256),
			(int) (g * ALMOST_256),
			(int) (b * ALMOST_256)];
}

- (NSString*) hexString32 NS_AVAILABLE_IOS(5_0){
	if([self respondsToSelector:@selector(getRed:green:blue:alpha:)] == NO){
		return nil;
	}
	
	float r,g,b,a;
	[self getRed:&r green:&g blue:&b alpha:&a];
	return [NSString stringWithFormat:@"#%02x%02x%02x%02x",
			(int) (r * ALMOST_256),
			(int) (g * ALMOST_256),
			(int) (b * ALMOST_256),
			(int) (a * ALMOST_256)];
}

@end
