//
//  AudioManager.m
//  kanarci
//
//  Created by Jan Remes on 21.04.14.
//  Copyright (c) 2014 Jan Remes. All rights reserved.
//

#import "AudioManager.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "FSKRecognizer.h"
#import "FSKSerialGenerator.h"
#import "AudioSignalAnalyzer.h"
#import "CharReceiver.h"

@interface AudioManager () <CharReceiver,AVAudioSessionDelegate>

@property (nonatomic,strong) FSKRecognizer *recognizer;
@property (nonatomic,strong) FSKSerialGenerator *generator;
@property (nonatomic,strong) AudioSignalAnalyzer *analyzer;

@end

@implementation AudioManager

+ (AudioManager *) sharedInstance {
    
    static AudioManager *instance = nil;
    
	static dispatch_once_t onceToken;
    
	dispatch_once(&onceToken, ^{
        if (instance == nil) {
	    	instance = [AudioManager new];
            
        }
        
        
	});
    
	return instance;
}

-(void) setup {
    AVAudioSession *session = [AVAudioSession sharedInstance];
	session.delegate = self;
	if(session.inputIsAvailable){
		[session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
	}else{
		[session setCategory:AVAudioSessionCategoryPlayback error:nil];
	}
	[session setActive:YES error:nil];
	[session setPreferredIOBufferDuration:0.023220 error:nil];
    
	self.recognizer = [[FSKRecognizer alloc] init];
	[self.recognizer addReceiver:self];
    
	self.generator = [[FSKSerialGenerator alloc] init];
	[self.generator play];
    
	self.analyzer = [[AudioSignalAnalyzer alloc] init];
	[self.analyzer addRecognizer:self.recognizer];
    
	if(session.inputIsAvailable){
		[self.analyzer record];
	}
    
    DLog(@"Audio manager setup finished");
}


- (void)inputIsAvailableChanged:(BOOL)isInputAvailable
{
	NSLog(@"inputIsAvailableChanged %d",isInputAvailable);
	
	AVAudioSession *session = [AVAudioSession sharedInstance];
	
	[self.analyzer stop];
	[self.generator stop];
	
	if(isInputAvailable){
		[session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
		[self.analyzer record];
	}else{
		[session setCategory:AVAudioSessionCategoryPlayback error:nil];
	}
	[self.generator play];
}

- (void)beginInterruption
{
	NSLog(@"beginInterruption");
}

- (void)endInterruption
{
	NSLog(@"endInterruption");
}

- (void)endInterruptionWithFlags:(NSUInteger)flags
{
	NSLog(@"endInterruptionWithFlags: %lx",(unsigned long)flags);
}

-(void)receivedChar:(char)input {
    
    if(isprint(input)){
    DLog(@"%c",input);
    }
}
@end
