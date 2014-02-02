/**
 
 Created by Jan Remes on 16.11.13.
 Copyright (c) 2013 eMan s.r.o. All rights reserved.
 
 */

#import "CVAudioSession.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation CVAudioSession

static BOOL _isInterrupted = NO;

+(void) setup {
    NSLog(@"CVAudioSession setup");
    
    // Set up the audio session for recording
    OSStatus error = AudioSessionInitialize(NULL, NULL, interruptionListener, (__bridge void*)self);
    
    if (error) NSLog(@"ERROR INITIALIZING AUDIO SESSION! %ld\n", error);
    if (!error) {
        UInt32 category = kAudioSessionCategory_RecordAudio; // NOTE CANT PLAY BACK WITH THIS
        error = AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(category), &category);
        if (error) NSLog(@"couldn't set audio category!");
        
        error = AudioSessionAddPropertyListener(kAudioSessionProperty_AudioRouteChange, propListener, (__bridge void*) self);
        if (error) NSLog(@"ERROR ADDING AUDIO SESSION PROP LISTENER! %ld\n", error);
        UInt32 inputAvailable = 0;
        UInt32 size = sizeof(inputAvailable);
        
        // we do not want to allow recording if input is not available
        error = AudioSessionGetProperty(kAudioSessionProperty_AudioInputAvailable, &size, &inputAvailable);
        if (error) NSLog(@"ERROR GETTING INPUT AVAILABILITY! %ld\n", error);
        
        // we also need to listen to see if input availability changes
        error = AudioSessionAddPropertyListener(kAudioSessionProperty_AudioInputAvailable, propListener, (__bridge void*) self);
        if (error) NSLog(@"ERROR ADDING AUDIO SESSION PROP LISTENER! %ld\n", error);
        
        error = AudioSessionSetActive(true);
        if (error) NSLog(@"CVAudioSession: AudioSessionSetActive (true) failed");
    }
}

+ (NSString*) currentAudioRoute {
    UInt32 routeSize = sizeof (CFStringRef);
    CFStringRef route;
    
    AudioSessionGetProperty (kAudioSessionProperty_AudioRoute,
                             &routeSize,
                             &route);
    
    NSString* routeStr = (__bridge NSString*)route;
    return routeStr;
}

+(void) destroy {
    NSLog(@"CVAudioSession destroy");
    
    // Very important - remove the listeners, or we'll crash when audio routes etc change when we're no longer on screen
    OSStatus stat = AudioSessionRemovePropertyListenerWithUserData(kAudioSessionProperty_AudioRouteChange, propListener, (__bridge void*)self);
    NSLog(@".. AudioSessionRemovePropertyListener kAudioSessionProperty_AudioRouteChange returned %ld", stat);
    
    stat = AudioSessionRemovePropertyListenerWithUserData(kAudioSessionProperty_AudioInputAvailable, propListener, (__bridge void*)self);
    NSLog(@".. AudioSessionRemovePropertyListener kAudioSessionProperty_AudioInputAvailable returned %ld", stat);
    
    AudioSessionSetActive(false); // disable audio session.
    NSLog(@"AudioSession is now inactive");
}

+(BOOL) interrupted {
    return _isInterrupted;
}

// Called when audio is interrupted for whatever reason. NOTE: doesn't always call the END one..
void interruptionListener(  void *  inClientData,
                          UInt32    inInterruptionState) {
    
    if (inInterruptionState == kAudioSessionBeginInterruption)
    {
        _isInterrupted = YES;
        
        NSLog(@"CVAudioSession: interruptionListener kAudioSessionBeginInterruption. Disable audio session..");
        
        // Try just deactivating the audiosession..
        OSStatus rc = AudioSessionSetActive(false);
        if (rc) {
            NSLog(@"CVAudioSession: interruptionListener kAudioSessionBeginInterruption - AudioSessionSetActive(false) returned %.ld", rc);
        } else {
            NSLog(@"CVAudioSession: interruptionListener kAudioSessionBeginInterruption - AudioSessionSetActive(false) ok.");
        }
        
        
        
    } else if (inInterruptionState == kAudioSessionEndInterruption) {
        
        _isInterrupted = NO;
        
        // Reactivate the audiosession
        OSStatus rc = AudioSessionSetActive(true);
        if (rc) {
            NSLog(@"CVAudioSession: interruptionListener kAudioSessionEndInterruption - AudioSessionSetActive(true) returned %.ld", rc);
        } else {
            NSLog(@"CVAudioSession: interruptionListener kAudioSessionEndInterruption - AudioSessionSetActive(true) ok.");
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kCVAudioInterruptionEnded object:(__bridge NSObject*)inClientData userInfo:nil];
    }
}

// This is called when microphone or other audio devices are plugged in and out. Is on the main thread
void propListener(  void *                  inClientData,
                  AudioSessionPropertyID    inID,
                  UInt32                  inDataSize,
                  const void *            inData)
{
    if (inID == kAudioSessionProperty_AudioRouteChange)
    {
        CFDictionaryRef routeDictionary = (CFDictionaryRef)inData;
        CFNumberRef reason = (CFNumberRef)CFDictionaryGetValue(routeDictionary, CFSTR(kAudioSession_AudioRouteChangeKey_Reason));
        SInt32 reasonVal;
        CFNumberGetValue(reason, kCFNumberSInt32Type, &reasonVal);
        if (reasonVal == kAudioSessionRouteChangeReason_NewDeviceAvailable)
        {
            NSLog(@"new audio available");
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kCVAudioInputNewDetectedNotification object:(__bridge NSObject*)inClientData userInfo:nil];
//            if (reasonVal != kAudioSessionRouteChangeReason_CategoryChange)
//            {
//                NSLog(@"CVAudioSession: input changed");
//                [[NSNotificationCenter defaultCenter] postNotificationName:kCVAudioInputChangedNotification object:(__bridge NSObject*)inClientData userInfo:nil];
//            }
        }
    }
    else if (inID == kAudioSessionProperty_AudioInputAvailable)
    {
        if (inDataSize == sizeof(UInt32)) {
            UInt32 isAvailable = *(UInt32*)inData;
            
            if (isAvailable == 0) {
                NSLog(@"AUDIO RECORDING IS NOT AVAILABLE");
            }
        }
    }
}

@end