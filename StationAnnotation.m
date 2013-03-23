//
//  StationAnnotation.m
//  SmogAlarm
//
//  Created by Vojtech Vrbka on 3/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StationAnnotation.h"
#import "Station.h"

@implementation StationAnnotation
@synthesize station = _station;

+ (StationAnnotation*)annotationForStation:(Station*)station {
    StationAnnotation *annotation = [[StationAnnotation alloc] init];
    annotation.station = station;
    return annotation;
}

- (NSString *) title {
    return self.station.name;
}

- (NSString *) subtitle {
    return  [NSString stringWithFormat:@"Kvalita ovzduší: %@",[self.station qualityString]]; 
}

-(CLLocationCoordinate2D)coordinate {
    return self.station.location.coordinate;
}

/*
 UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
 [rightButton addTarget:self
 action:@selector(showDetails:)
 forControlEvents:UIControlEventTouchUpInside];
 
 customPinView.rightCalloutAccessoryView = rightButton;
 */

@end
