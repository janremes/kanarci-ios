//
//  DataController.h
//  SmogAlarm
//
//  Created by Vojtech Vrbka on 2/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "Station.h"
#import "Measurement.h"

//Delegate methods giving Statin controller information about stop animating
@protocol DataControllerDelegate <NSObject>

// finished loading and processed data
-(void)dataDidFinishLoading;

@end


extern const NSString *KNMeasureDataChangedNotification;

@interface KNDataManager : NSObject <CLLocationManagerDelegate> {
    NSMutableArray *stations;
    NSDate *stationsLoadTime;
    NSMutableData *responseData;
    
    
    CLLocationManager *locationManager;
    CLLocation *location;
    id<DataControllerDelegate> __unsafe_unretained  delegate;
    
    BOOL positionLoaded;
    BOOL dataLoaded;
    BOOL tokenLoaded;
    BOOL positionBlocked;
    BOOL iCloudAvailable;
    
    
}
@property (nonatomic, strong) NSMutableArray *stations;
@property (nonatomic, strong) NSDate *stationsLoadTime;
@property (nonatomic, strong) NSMutableData *responseData;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *location;

@property (unsafe_unretained) id <DataControllerDelegate> delegate;

@property (readwrite, assign) BOOL positionLoaded;
@property (readwrite, assign) BOOL dataLoaded;
@property (readwrite, assign) BOOL tokenLoaded;
@property (readwrite, assign) BOOL positionBlocked;
@property (readwrite, assign) BOOL iCloudAvailable;


+ (KNDataManager *) sharedInstance;

- (void) loadPosition;

- (Station *) getNearestStation;

- (void) loadStationsWithSuccess:(void (^)(NSArray *stations))success
                         failure:(void (^)(NSError *error))failure;

- (void) loadKanarciWithSuccess:(void (^)(NSArray *stations))success
                        failure:(void (^)(NSError *error))failure;

-(void) saveMeasure:(Measurement *) measure;
-(NSArray *) getAllMeasures;

//statistics
-(NSArray *) getMeasuresForMonth:(int) month year:(int) year ;
-(NSArray *) getLastWeekBarItems ;
-(NSArray *) getLastBarItemsForDays:(int) days;
-(NSArray *) getLastBarItemsForHours:(int) hours;
@end
