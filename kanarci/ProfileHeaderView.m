//
//  ProfileHeaderView.m
//  kanarci
//
//  Created by Jan Remes on 14.03.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import "ProfileHeaderView.h"

@implementation ProfileHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor] ];
        
        CGFloat imageSize = 81;
        _profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width/2) - imageSize/2, 0, imageSize, imageSize)];
        [_profileImageView setImage:[UIImage imageNamed:@"profile_header_me"]];
        [_profileImageView setBackgroundColor:[UIColor greenColor]];
        
        [self addSubview:_profileImageView];
    }
    return self;
}



@end
