//
//  KNSegmentedButton.m
//  kanarci
//
//  Created by Jan Remes on 31.03.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import "KNSegmentedButton.h"
#import <QuartzCore/QuartzCore.h>

@implementation KNSegmentedButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}



-(void)setupView{
    
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowRadius = 1;
    self.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
    
    self.segmentedControlStyle = UISegmentedControlStylePlain;
    
    
    
}

@end
