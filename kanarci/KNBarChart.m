//
//  KNBarChart.m
//  kanarci
//
//  Created by Jan Remes on 03.04.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import "KNBarChart.h"

@implementation KNBarChart {
    UILabel *titleMonthLabel;
    UILabel *titleYearLabel;
    UILabel *titleWeekLabel;
    UIImageView *_backgroundImageView;
    UIImageView *_tableLegendImageView;
    KNBarChartType _chartType;
}

- (id)initWithFrame:(CGRect)frame barChartType:(KNBarChartType) barChartType
{
    self = [super initWithFrame:frame];
    if (self) {
        _chartType = barChartType;
        
        [self createUI];
        
    }
    return self;
}

- (void) createUI {
    
    _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kn_bar_chart"]];
    
    _backgroundImageView.top = 50;
        
    [self addSubview:_backgroundImageView];
    
     [_backgroundImageView centerHorizontally];
    

    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
