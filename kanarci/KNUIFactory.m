//
//  KNUIFactory.m
//  kanarci
//
//  Created by Jan Remes on 23.03.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import "KNUIFactory.h"

@implementation KNUIFactory



+ (UILabel *)labelWithFontSize:(CGFloat)size bold:(BOOL)bold
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 12)];
    label.backgroundColor = [UIColor clearColor];
    label.font = (bold ? [Theme boldAppFontOfSize:size] : [Theme appFontOfSize:size]);
    label.numberOfLines = 1;
    label.textColor = [UIColor blackColor];
    label.textAlignment = UITextAlignmentLeft;
    label.lineBreakMode = UILineBreakModeTailTruncation;
    label.adjustsFontSizeToFitWidth = YES;
    label.minimumFontSize = size/1.3;
    
    return label;
}

@end
