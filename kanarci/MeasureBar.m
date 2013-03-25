//
//  MeasureBar.m
//  kanarci
//
//  Created by Jan Remes on 23.03.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
// Dimensions are 60x250

#import "MeasureBar.h"

@implementation MeasureBar {
    NSMutableArray *_markers;
    UIImageView *_arrow;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void) initUI{
    
    [self setBackgroundColor:[UIColor whiteColor]];
    
    [self setUserInteractionEnabled:NO];
    
    // layout air quality markers
    
    int gap = 10;
    int y =  230;
    int x = 5+13;
    
    _markers = [[NSMutableArray alloc] initWithCapacity:7];
    
    for (int i = 0 ; i < 7; i++) {
        UIImageView *qualityMarker = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat: @"air_quality%d.png",i] ]];
        
        [qualityMarker setCenter:CGPointMake(x, y)];
        y-=(gap + qualityMarker.frame.size.height);
        [self addSubview:qualityMarker];
        [_markers addObject:qualityMarker];
    
    
    }
    
    
    // init arrow
    
     _arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"measure_bar_arrow"]];
    
    
    [_arrow setCenter:CGPointMake(45, 230)];
    
    [self addSubview:_arrow];
    
    
    
}


-(void) updateArrowToValue:(int) value {
    
    CGPoint oldCenter = _arrow.center;
    CGFloat newY = [[_markers objectAtIndex:value] center].y;
    
    [UIView animateWithDuration:0.9
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseInOut  
                     animations:^{
                         
                         [_arrow setCenter:CGPointMake(oldCenter.x, newY)];
                         
                     }
                     completion:^(BOOL finished){
                      //   NSLog(@"Arrow moved!");
                     }];
    
    
}

@end
