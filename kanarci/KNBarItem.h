//
//  KNBarItem.h
//  kanarci
//
//  Created by Jan Remes on 12.01.14.
//  Copyright (c) 2014 Jan Remes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNBarItem : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) UIColor *color;
@property (nonatomic,strong) NSNumber *value;

@end
