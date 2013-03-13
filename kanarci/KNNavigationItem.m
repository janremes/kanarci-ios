//
//  KNNavigationItem.m
//  kanarci
//
//  Created by Jan Remes on 13.03.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import "KNNavigationItem.h"

@implementation KNNavigationItem {
    UILabel *_titleLabel;
}


-(void)awakeFromNib {
    [self setup];
}

-(void) setup {
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = self.title;
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor darkTextColor];
    _titleLabel.shadowColor = [UIColor whiteColor];
    _titleLabel.shadowOffset = CGSizeMake(0, 1);
    _titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:21.0];
    [_titleLabel sizeToFit];
    
    
    [self setTitleView:_titleLabel];
    

    
    
}


-(void)setTitle:(NSString *)title {
    [_titleLabel setText:title];
}


@end
