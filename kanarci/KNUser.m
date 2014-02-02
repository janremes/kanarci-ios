//
//  KNUserDefaults.m
//  kanarci
//
//  Created by Jan Remes on 01.04.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import "KNUser.h"

@implementation KNUser

-(void)encodeWithCoder:(NSCoder *)coder { [self autoEncodeWithCoder:coder]; }

-(id)initWithCoder:(NSCoder *)coder { if (self = [super init]) { [self autoDecode:coder]; } return self; }








@end
