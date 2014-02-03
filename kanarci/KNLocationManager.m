//
//  KNLocationManager.m
//  kanarci
//
//  Created by Jan Remes on 02.02.14.
//  Copyright (c) 2014 Jan Remes. All rights reserved.
//

#import "KNLocationManager.h"
#import <CoreMotion/CoreMotion.h>
#import <CoreLocation/CoreLocation.h>

@interface KNLocationManager () <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic, strong) CMStepCounter *stepCounter;
@property (nonatomic,strong) NSDate* startedObservingStepCount;
@property (nonatomic,strong) KNActivity* activity;
@end

@implementation KNLocationManager



+ (KNLocationManager *) sharedInstance {
    
    static KNLocationManager *instance = nil;
    
	static dispatch_once_t onceToken;
    
	dispatch_once(&onceToken, ^{
        if (instance == nil) {
	    	instance = [KNLocationManager new];
            [instance doInit];
        }
        
	});
	return instance;
}

-(void) doInit {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager setActivityType:CLActivityTypeFitness];
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([CMStepCounter isStepCountingAvailable]) {
        self.stepCounter = [[CMStepCounter alloc] init];
        
    }

}

-(void)startObservingLocation {
    [self.locationManager startUpdatingLocation];
}

-(void)stopObservingLocation {
    [self.locationManager stopUpdatingLocation];
}


#pragma mark - Location manager delegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    if(error.code == kCLErrorDenied) {
        [self.locationManager stopUpdatingLocation];
        
    } else if(error.code == kCLErrorLocationUnknown) {
        // retry
    } else {
        DLog(@"Location manager failed");
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    DLog(@"New location observed %@", [locations lastObject]);
    
    if (self.delegate) {
        for (CLLocation *location in locations) {
            [self.delegate locationUpdated:location];
        }
    }

}

#pragma mark - Step Counter

-(void)startObservingStepCount {

    if (!self.stepCounter) {
        return;
    }
        __weak typeof(self) wself = self;
    self.startedObservingStepCount = [NSDate new];
    [self.stepCounter startStepCountingUpdatesToQueue:[NSOperationQueue mainQueue]
                                                 updateOn:1
                                              withHandler:^(NSInteger numberOfSteps, NSDate *timestamp, NSError *error) {
                                                  DLog(@"%s %ld %@ %@", __PRETTY_FUNCTION__, (long)numberOfSteps, timestamp, error);
                                                 
                                                  if (wself.delegate) {
                                                      [wself.delegate stepCountUpdatedWithCount:numberOfSteps timestamp:timestamp error:error];
                                                  }
                                              }];
    
}

-(void)stopObservingStepCount {
    [self.stepCounter stopStepCountingUpdates];
    if (self.delegate) {
        __weak typeof(self) wself = self;
          NSDate *now = [NSDate date];
        [self.stepCounter queryStepCountStartingFrom:self.startedObservingStepCount
                                                  to:now
                                             toQueue:[NSOperationQueue mainQueue]
                                         withHandler:^(NSInteger numberOfSteps, NSError *error) {
                                             DLog(@"%s %ld %@", __PRETTY_FUNCTION__, (long)numberOfSteps, error);
                                          [wself.delegate stepCountUpdatedWithCount:numberOfSteps timestamp:nil error:error];
                                         }];
        
    }
}

-(void)queryStepCounterStartDate:(NSDate *)startDate endDate:(NSDate *)endDate completion:(void (^)(NSInteger))completion {
    [self.stepCounter queryStepCountStartingFrom:startDate
                                              to:endDate
                                         toQueue:[NSOperationQueue mainQueue]
                                     withHandler:^(NSInteger numberOfSteps, NSError *error) {
                                         DLog(@"%s %ld %@", __PRETTY_FUNCTION__, (long)numberOfSteps, error);
                                         if (completion) {
                                             completion(numberOfSteps);
                                         }
                                     }];
}

@end
