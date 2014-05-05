//
//  StationRowView.h
//  kanarci
//
//  Created by Jan Remes on 05.05.14.
//  Copyright (c) 2014 Jan Remes. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StationMeasurement;
@interface StationRowView : UIView



-(void) setupWithStationMeasurement:(StationMeasurement *) measurement;
-(void) animate;
@end
