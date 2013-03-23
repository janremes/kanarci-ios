//
//  StationMeasurement.h
//  SmogAlarm
//
//  Created by Vojtech Vrbka on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Station.h"
@class Station;

@interface StationMeasurement : NSObject {
    Station *station;
    NSString *name;
    NSDecimalNumber *value;

}
+(StationMeasurement*)stationMeasurementForName:(NSString*)name andValue:(NSDecimalNumber*)value andStation:(Station*)station;
+(NSString*)titleForMeasurement:(NSString*)measurement;
+(NSArray*)qualityLevelsForMeasurement:(NSString*)measurement;
-(NSString*)getTitle;
-(NSString*)getDescription;
-(int) getQuality;
-(NSArray*)getQualityLevels;
-(NSString*)getLevelForSlider:(int)quality;
-(NSString*)getFormatedValue;
-(BOOL)haveIndex;
@property (nonatomic, retain) Station *station;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSDecimalNumber *value;

@end
