//
//  KNMeasureFactory.m
//  kanarci
//
//  Created by Jan Remes on 25.03.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import "KNMeasureHelper.h"

@implementation KNMeasureHelper


+(NSString *) getQualityStringForValue:(int) value{
        NSArray *qualities = [[NSArray alloc] initWithObjects:@"nezaměřeno",@"velmi dobrá",@"dobrá",@"uspokojivá",@"vyhovující",@"špatná",@"velmi špatná", nil];
    
    return [qualities objectAtIndex:value];
    
}


+(NSString *)getImageNameForBucketValue:(int)value {
    return [NSString stringWithFormat:@"air_quality%d",value];
}

@end
