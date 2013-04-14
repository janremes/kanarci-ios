//
//  KNUserDefaults.h
//  kanarci
//
//  Created by Jan Remes on 01.04.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNUser : NSObject



@property (nonatomic,strong) NSString *cosmApiKey;
@property (nonatomic,strong) NSString *email;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *password;
@property(nonatomic, readonly) NSString *userId;

@property(nonatomic,assign) BOOL needsLogin;


+ (KNUser *) sharedInstance ;


- (BOOL)setUserId:(NSString *)userId andPassword:(NSString *)password error:(NSError **)error;

@end
