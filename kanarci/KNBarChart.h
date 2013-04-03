//
//  KNBarChart.h
//  kanarci
//
//  Created by Jan Remes on 03.04.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    KNBarChartWeekType,
    KNBarChartMonthType
} KNBarChartType;

@interface KNBarChart : UIView




- (id)initWithFrame:(CGRect)frame barChartType:(KNBarChartType) barChartType;

@end
