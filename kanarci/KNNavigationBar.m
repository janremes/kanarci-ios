//
//  KNNavigationBar.m
//  kanarci
//
//  Created by Jan Remes on 13.03.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import "KNNavigationBar.h"

@implementation KNNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

-(void)awakeFromNib {
    [self setup];
}

-(id)init{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;

}



-(void) setup {
//    [self setTitleTextAttributes:@{
//       UITextAttributeTextColor : [Theme defaultTextColor],
// UITextAttributeTextShadowColor : [UIColor clearColor],
//            UITextAttributeFont : [Theme boldAppFontOfSize:20.0]}];
    
    
}




// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
 UIImage *image = [UIImage imageNamed: @"navbar_bg"];
 [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
  
}


- (CGSize)sizeThatFits:(CGSize)size {
    [self setTitleVerticalPositionAdjustment:-10 forBarMetrics:UIBarMetricsDefault];
    return CGSizeMake(self.frame.size.width, 58.0);
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setTitleVerticalPositionAdjustment:-10 forBarMetrics:UIBarMetricsDefault];
    CGRect barFrame = self.frame;
    barFrame.size.height = 58.0;
    self.frame = barFrame;
    

}

@end
