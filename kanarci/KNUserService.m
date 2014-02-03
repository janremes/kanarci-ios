//
//  KNUserService.m
//  kanarci
//
//  Created by Jan Remes on 02.02.14.
//  Copyright (c) 2014 Jan Remes. All rights reserved.
//

#import "KNUserService.h"
#import "KNUser.h"

#import <Lockbox/Lockbox.h>
#import <AFNetworking.h>
#import "NSDictionary+EMSafeParsing.h"

static NSString *const kUserDocumentsPath = @"kUserDocumentsPath";
static NSString *const kPasswordLockBox = @"kPasswordLockBox";

@interface KNUserService ()

@property (nonatomic,strong) KNUser *currentUser;
@property (nonatomic,assign,readwrite) BOOL needsLogin;

@end

@implementation KNUserService


+ (KNUserService *) sharedInstance {
    
    static KNUserService *instance = nil;
    
	static dispatch_once_t onceToken;
    
	dispatch_once(&onceToken, ^{
        if (instance == nil) {
	    	instance = [KNUserService new];
            [instance doInit];
        }
        
        
	});
    
	return instance;
}

-(void) doInit {
    
 //   [self deleteAllUserData];
    
    self.currentUser = [Archiver retrieve:kUserDocumentsPath];
    
    if (!self.currentUser) {
        self.needsLogin = YES;
    } else {
        self.needsLogin = NO;
    }
}

-(void)signUpUserWith:(NSString *)email password:(NSString *)password success:(void (^)(KNUser *))success failure:(void (^)(NSError *))failure {
    if (!email || !password) {
        if (failure) {
            failure(nil);
        }
    }
    
    __weak typeof(self) wself = self;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSDictionary *params = @{@"u": email, @"p": password};
    [manager GET:@"http://kanarci.cz/api/sign-up" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"%@", responseObject);
        
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *dict = responseObject;
            if ([[dict numberOrNilForKey:@"error"] boolValue]) {
                
                if (failure) {
                    failure(nil);
                }
            } else {
                
                //sucess
                [wself insertUserWithDictionary:responseObject];
                [Lockbox setString:password forKey:kPasswordLockBox];
                
                if (success) {
                    success(self.currentUser);
                }
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
}

-(void)loginUserWith:(NSString *)email password:(NSString *)password success:(void (^)(KNUser *))success failure:(void (^)(NSError *))failure {

    if (!email || !password) {
        if (failure) {
            failure(nil);
        }
    }
    
    __weak typeof(self) wself = self;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    NSDictionary *params = @{@"u": email, @"p": password};
    [manager POST:@"http://kanarci.cz/api/sign-in" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"%@ , %@", responseObject,operation);
        
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
    
            NSDictionary *dict = responseObject;
            if ([dict stringOrNilForKey:@"error"]) {
              
                if (failure) {
                    failure(nil);
                }
            } else {
                
                //sucess
                [wself insertUserWithDictionary:responseObject];
                [Lockbox setString:password forKey:kPasswordLockBox];
                
                if (success) {
                    success(self.currentUser);
                }
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     
        if (failure) {
            failure(error);
        }
    }];
    
}

-(void) insertUserWithDictionary:(NSDictionary *) dictionary {

    KNUser *user = [KNUser new];
    NSDictionary *userDict = [dictionary dictionaryOrNilForKey:@"user"];
    if (userDict) {
        user.email = [userDict stringOrNilForKey:@"email"];
        user.feedId = [userDict numberOrNilForKey:@"feed_id"];
        user.confirmed = [[userDict numberOrNilForKey:@"confirmed"] boolValue];
    }
    
    //TODO: fix creating feeds on server
    
    if ([user.feedId integerValue] == 0) {
        user.feedId = @150;
    }
    
    self.currentUser = user;
    self.needsLogin = NO;
    
    [Archiver persist:user key:kUserDocumentsPath];
    
}




-(void)logoutCurrentUser {
    self.currentUser = nil;
    [self deleteAllUserData];
    self.needsLogin = YES;
}


-(void) deleteAllUserData {
    [Archiver delete:kUserDocumentsPath];
    [Lockbox setString:nil forKey:kPasswordLockBox];
}

@end
