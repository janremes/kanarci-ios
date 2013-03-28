//
//  KNMeasureFactory.h
//  kanarci
//
//  Created by Jan Remes on 25.03.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNMeasureHelper : NSObject


/**
    Accepts value and converts to descriptive string
    @param value Value between 0 and 6
    @return String with description
 
 */

+(NSString *) getQualityStringForValue:(int) value;
+(NSString *) getImageNameForBucketValue:(int) value;

@end
