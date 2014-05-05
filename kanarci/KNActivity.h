//
//  KNActivity.h
//  kanarci
//
//  Created by Jan Remes on 03.02.14.
//  Copyright (c) 2014 Jan Remes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNActivity : NSObject <NSCoding>

@property (nonatomic,assign) BOOL measureLocation;
@property (nonatomic,assign) BOOL measureSteps;
@property (nonatomic,assign) NSInteger stepCount;
@property (nonatomic,strong) NSMutableArray *locations;
@property (nonatomic,strong) NSDate *startedStepCountingDate;
@end
