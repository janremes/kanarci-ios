//
//  MeasureBar.h
//  kanarci
//
//  Created by Jan Remes on 23.03.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeasureBar : UIView


/**
 
    Updates arrow to new value
 
    @param value Value between 0-6;

*/

-(void) updateArrowToValue:(int) value;

@end
