//
//  MeasurementManager.m
//  kanarci
//
//  Created by Jan Remes on 23.03.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import "MeasurementManager.h"

@implementation MeasurementManager



+ (MeasurementManager *)sharedManager {
    
    static MeasurementManager *sharedManager = nil;
    
	static dispatch_once_t onceToken;
    
	dispatch_once(&onceToken, ^{
        
		sharedManager = [MeasurementManager new];
        
	});
    
	return sharedManager;
}

@end
