/**
 
 <#Insert description#>
 
 Created by Jan Remes on 16.11.13.
 Copyright (c) 2013 eMan s.r.o. All rights reserved.
 
 */

#import <Foundation/Foundation.h>

#define kCVAudioInputChangedNotification @"kCVAudioInputChangedNotification"
#define kCVAudioInputNewDetectedNotification @"kCVAudioInputNewDetectedNotification"
#define kCVAudioInterruptionEnded @"kCVAudioInterruptionEnded"

@interface CVAudioSession : NSObject
+(void) setup;
+(void) destroy;
+(NSString*) currentAudioRoute;
+(BOOL) interrupted;
@end