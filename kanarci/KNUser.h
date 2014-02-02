//
//  KNUserDefaults.h
//  kanarci
//
//  Created by Jan Remes on 01.04.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNUser : NSObject <NSCoding>


@property (nonatomic,strong) NSString *email;
@property (nonatomic,strong) NSString *name;
@property (nonatomic, readonly) NSString *userId;
@property (nonatomic, strong) NSNumber *feedId;
@property (nonatomic, assign) BOOL confirmed;


@end
