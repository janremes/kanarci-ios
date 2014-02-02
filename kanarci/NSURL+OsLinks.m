/**
 
 Created by Martin Dohnal.
 Copyright (c) 2012 eMan s.r.o. All rights reserved.
 
 */

#import "NSURL+OsLinks.h"


@implementation NSURL (OsLinks)

+(NSURL*) URLWithPhone:(NSString*)inPhoneNum{
	NSString* withoutSpaces = [inPhoneNum stringByReplacingOccurrencesOfString:@" " withString:@""];
	NSString* encoded = [withoutSpaces stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	return [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", encoded]];
}

+(NSURL*) URLWithPhoneSMS:(NSString*)inPhoneNum{
	NSString* withoutSpaces = [inPhoneNum stringByReplacingOccurrencesOfString:@" " withString:@""];
	NSString* encoded = [withoutSpaces stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	return [NSURL URLWithString:[NSString stringWithFormat:@"sms:%@", encoded]];
}

+(NSURL*) URLWithMail:(NSString*)inMail{
	return [NSURL URLWithString:[NSString stringWithFormat:@"mailto:%@", [inMail stringByReplacingOccurrencesOfString:@" " withString:@""]]];
}

+(NSURL*) URLWithGPSTo:(CLLocation*)inTo{
	return [self URLWithGPSToCoordinate:inTo.coordinate];
}

+(NSURL*) URLWithGPSFrom:(CLLocation*)inFrom to:(CLLocation*)inTo{
	return [self URLWithGPSFromCoordinate:inFrom.coordinate toCoordinate:inTo.coordinate];
}

+(NSURL*) URLWithGPSToCoordinate:(CLLocationCoordinate2D)inTo{
	
	NSString* nav = nil;
	
	if(SYSTEM_VERSION_LESS_THAN(@"6.0")){
		// uses google maps app
		nav = [NSString stringWithFormat:@"http://maps.google.com/?daddr=%f,%f", inTo.latitude, inTo.longitude];
	}
	else{
		// uses apple maps app
		nav = [NSString stringWithFormat:@"http://maps.apple.com/?daddr=%f,%f", inTo.latitude, inTo.longitude];
	}
	
    return [NSURL URLWithString:nav];
}

+(NSURL*) URLWithGPSFromCoordinate:(CLLocationCoordinate2D)inFrom toCoordinate:(CLLocationCoordinate2D)inTo{
	
	NSString* nav = nil;
	
    if (!CLLocationCoordinate2DIsValid(inFrom)) {
        return [self URLWithGPSToCoordinate:inTo];
    }
    
	if(SYSTEM_VERSION_LESS_THAN(@"6.0")){
		// uses google maps app
		nav = [NSString stringWithFormat:@"http://maps.google.com/?saddr=%f,%f&daddr=%f,%f", inFrom.latitude, inFrom.longitude, inTo.latitude, inTo.longitude];
	}
	else{
		// uses apple maps app
		nav = [NSString stringWithFormat:@"http://maps.apple.com/?saddr=%f,%f&daddr=%f,%f", inFrom.latitude, inFrom.longitude, inTo.latitude, inTo.longitude];
	}
	
    return [NSURL URLWithString:nav];
}

-(BOOL) isMapURL{
	return [[self absoluteString] hasPrefix:@"http://maps.google.com"] || [[self absoluteString] hasPrefix:@"http://maps.apple.com"];
}

-(BOOL) isPhoneURL{
	return [[self absoluteString] hasPrefix:@"tel"];
}

@end
