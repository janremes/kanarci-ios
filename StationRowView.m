//
//  StationRowView.m
//  kanarci
//
//  Created by Jan Remes on 05.05.14.
//  Copyright (c) 2014 Jan Remes. All rights reserved.
//

#import "StationRowView.h"
#import "StationMeasurement.h"

@interface StationRowView ()
@property (nonatomic,strong) IBOutlet UILabel *titleLabel;
@property (nonatomic,strong) IBOutlet UILabel *valueLabel;
@property (nonatomic,strong) IBOutlet UIImageView *qualityMark;

@end

@implementation StationRowView




- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = (StationRowView *)[[[NSBundle mainBundle] loadNibNamed:@"StationRowView" owner:self options:nil] objectAtIndex:0];
        self.frame = frame;
        
        
        
    }
    return self;
}

-(void)setupWithStationMeasurement:(StationMeasurement *)measurement {
    self.titleLabel.text = [[[measurement getTitle] lowercaseString] stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[measurement getTitle] substringToIndex:1] ];
    
    self.valueLabel.text =[NSString stringWithFormat:@"%@ μg/m%@",[measurement getFormatedValue],@"\u00B3"];
    
    NSString *pinName = [NSString stringWithFormat:@"air_quality%d",[measurement getQuality]];
    
    self.qualityMark.image = [UIImage imageNamed:pinName];
}

@end
