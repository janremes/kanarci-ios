//
//  KNUserService.h
//  kanarci
//
//  Created by Jan Remes on 02.02.14.
//  Copyright (c) 2014 Jan Remes. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Class for communicating with kanarci.cz API
    Is used for registration and login of new user
 */

@class KNUser;
@interface KNUserService : NSObject

@property(nonatomic,assign,readonly) BOOL needsLogin;

+ (KNUserService *) sharedInstance;

-(void)signUpUserWith:(NSString *)email password:(NSString *)password success:(void (^)(KNUser *user))success failure:(void (^)(NSError *error))failure;
-(void)loginUserWith:(NSString *)email password:(NSString *)password success:(void (^)(KNUser *user))success failure:(void (^)(NSError *error))failure;
-(void)logoutCurrentUser;

@end
