/**
 
 OS links category for NSURL
 
 See http://developer.apple.com/library/ios/featuredarticles/iPhoneURLScheme_Reference/iPhoneURLScheme_Reference.pdf
 
 Created by Martin Dohnal.
 Copyright (c) 2012 eMan s.r.o. All rights reserved.
 
 */

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface NSURL (OsLinks)

/**
 @param inPhoneNum phone number
 @return URL for calling phone number
 */
+(NSURL*) URLWithPhone:(NSString*)inPhoneNum;

/**
 @param inPhoneNum phone number
 @return URL for sending SMS to a phone number
 */
+(NSURL*) URLWithPhoneSMS:(NSString*)inPhoneNum;

/**
 @param inMail email address
 @return URL for email address
 */
+(NSURL*) URLWithMail:(NSString*)inMail;

/**
 URL for navigation to a given location using maps app.
 Uses different URLs depending on current iOS version.
 
 @param inTo to GPS location
 @return URL for navigation from a given location to a given location using maps app
 */
+(NSURL*) URLWithGPSTo:(CLLocation*)inTo;

/**
 URL for navigation from a given location to a given location using maps app.
 Uses different URLs depending on current iOS version.
 
 @param inFrom from GPS location
 @param inTo to GPS location
 @return URL for navigation from a given location to a given location using maps app
 */
+(NSURL*) URLWithGPSFrom:(CLLocation*)inFrom to:(CLLocation*)inTo;

/**
 URL for navigation to a given location using maps app.
 Uses different URLs depending on current iOS version.
 
 @param inTo to GPS coordinate
 @return URL for navigation from a given location to a given location using maps app
 */
+(NSURL*) URLWithGPSToCoordinate:(CLLocationCoordinate2D)inTo;

/**
 URL for navigation from a given location to a given location using maps app.
 Uses different URLs depending on current iOS version.
 
 @param inFrom from GPS coordinate
 @param inTo to GPS coordinate
 @return URL for navigation from a given location to a given location using maps app
 */
+(NSURL*) URLWithGPSFromCoordinate:(CLLocationCoordinate2D)inFrom toCoordinate:(CLLocationCoordinate2D)inTo;

/**
 @return if URL is a map application URL
 */
-(BOOL) isMapURL;

/**
 @return if URL is a phone URL
 */
-(BOOL) isPhoneURL;

@end
