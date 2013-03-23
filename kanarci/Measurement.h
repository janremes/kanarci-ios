//
//  Measurement.h
//  kanarci
//
//  Created by Jan Remes on 14.03.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface Measurement : NSObject {
    NSDate *date;
    NSInteger bucketValue;
    NSNumber *preciseValue;
    NSString *qualityString;
    
    //location info
    NSString *thoroughfare;
    NSString *locality;
    NSString *country;
    double longtitude;
    double latitude;
    
}

@property (nonatomic,strong) NSDate *date;
@property (nonatomic,strong) NSNumber *preciseValue;
@property (nonatomic,strong) NSString *qualityString;
@property (nonatomic) NSInteger bucketValue;

@property (nonatomic,strong) NSString *thoroughfare;
@property (nonatomic,strong) NSString *locality;
@property (nonatomic,strong) NSString *country;
@property (nonatomic) double longtitude;
@property (nonatomic) double latitude;

@end
