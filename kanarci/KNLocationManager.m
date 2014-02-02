//
//  KNLocationManager.m
//  kanarci
//
//  Created by Jan Remes on 02.02.14.
//  Copyright (c) 2014 Jan Remes. All rights reserved.
//

#import "KNLocationManager.h"

@implementation KNLocationManager



+ (KNLocationManager *) sharedInstance {
    
    static KNLocationManager *instance = nil;
    
	static dispatch_once_t onceToken;
    
	dispatch_once(&onceToken, ^{
        if (instance == nil) {
	    	instance = [KNLocationManager new];
            
        }
        
	});
	return instance;
}


@end
