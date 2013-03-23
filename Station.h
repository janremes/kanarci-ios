//
//  Station.h
//  SmogAlarm
//
//  Created by Vojtech Vrbka on 1/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "StationMeasurement.h"
@class StationMeasurement;

@interface Station : NSObject {
    NSInteger number;
    NSString *code;
    NSString *name;
    NSString *date;
    CLLocation *location;
    
    NSMutableDictionary *measurements;
    NSNumber *totalQuality;
    NSMutableArray *measurementsTableOrder;
}
-(NSString*)getShortName;
-(NSString*)nameForTitle;
-(NSString*)nameForTable;
-(NSString *)qualityString;
-(UIColor *)qualityColor;
+(UIColor *)getColorForQuality:(int)quality;
-(NSString *)toString;
-(UIImage *)mapPinImage;
-(StationMeasurement *)getMeasurement:(NSString*)measurement;
-(StationMeasurement*) getMeasurementForTable:(int)index;
-(BOOL)isEqualToStation:(Station*)station;

@property (readwrite, assign) NSInteger number;
@property (nonatomic, retain) NSString *code;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *date;
@property (nonatomic, retain) CLLocation *location;

@property (nonatomic, retain) NSMutableDictionary *measurements;
@property (nonatomic, retain) NSNumber *totalQuality;

-(id)initWithDictionaryData:(NSDictionary *)dictionary ;


@end
