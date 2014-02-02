/**
 
 Created by Martin Dohnal.
 Copyright (c) 2012 eMan s.r.o. All rights reserved.
 
 */

#import "UIButton+eMan.h"

@implementation UIButton (eMan)

-(NSString *)title{
	return [self titleForState:UIControlStateNormal];
}

-(void)setTitle:(NSString *)title{
	[self setTitle:title forState:UIControlStateNormal];
}

@end
