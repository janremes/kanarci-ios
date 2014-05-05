//
//  KNActivity.m
//  kanarci
//
//  Created by Jan Remes on 03.02.14.
//  Copyright (c) 2014 Jan Remes. All rights reserved.
//

#import "KNActivity.h"

@implementation KNActivity

-(void)encodeWithCoder:(NSCoder *)coder { [self autoEncodeWithCoder:coder]; }

-(id)initWithCoder:(NSCoder *)coder { if (self = [super init]) { [self autoDecode:coder]; } return self; }




@end
