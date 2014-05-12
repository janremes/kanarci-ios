//
//  KNMeasureFactory.m
//  kanarci
//
//  Created by Jan Remes on 25.03.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import "KNMeasureHelper.h"

@implementation KNMeasureHelper


+(NSString *) getQualityStringForValue:(NSInteger) value{
        NSArray *qualities = [[NSArray alloc] initWithObjects:@"nezaměřeno",@"velmi dobrá",@"dobrá",@"uspokojivá",@"vyhovující",@"špatná",@"velmi špatná", nil];
    
    return [qualities objectAtIndex:value];
    
}


+(NSString *)getImageNameForBucketValue:(NSInteger)value {
    return [NSString stringWithFormat:@"air_quality%ld",(long)value];
}

@end
