//
//  StationAnnotation.h
//  SmogAlarm
//
//  Created by Vojtech Vrbka on 3/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mapkit/Mapkit.h>
#import "Station.h"

@interface StationAnnotation : NSObject <MKAnnotation>

+(StationAnnotation *) annotationForStation:(Station*)station;
@property (nonatomic, retain) Station *station;
@end
