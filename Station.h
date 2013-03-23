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
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) CLLocation *location;

@property (nonatomic, strong) NSMutableDictionary *measurements;
@property (nonatomic, strong) NSNumber *totalQuality;

-(id)initWithDictionaryData:(NSDictionary *)dictionary ;


@end
