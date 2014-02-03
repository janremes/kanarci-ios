//
//  KNLocationManager.h
//  kanarci
//
//  Created by Jan Remes on 02.02.14.
//  Copyright (c) 2014 Jan Remes. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KNLocationManagerDelegate <NSObject>

@optional
-(void) stepCountUpdatedWithCount:(NSInteger) totalNumberOfSteps timestamp:(NSDate *) timestamp error:(NSError *) error;

-(void) locationUpdated:(CLLocation *) newLocation;

@end

@class KNActivity;
@interface KNLocationManager : NSObject

@property (nonatomic, weak) id<KNLocationManagerDelegate> delegate;


+ (KNLocationManager *) sharedInstance;

-(void) setNewActivity:(KNActivity *) activity;

-(void) startObservingLocation;
-(void) stopObservingLocation;

-(void) startObservingStepCount;
-(void) stopObservingStepCount;
-(void) queryStepCounterStartDate:(NSDate *) startDate endDate:(NSDate *) endDate completion:(void (^)(NSInteger stepCount))completion ;

@end
