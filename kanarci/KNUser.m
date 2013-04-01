//
//  KNUserDefaults.m
//  kanarci
//
//  Created by Jan Remes on 01.04.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import "KNUser.h"
#import "SFHFKeychainUtils.h"
#import "COSMAPI.h"


#define kServiceDomainName @"com.neobab.kanarci"
#define kUserIdDefaultsKey @"UserIdDefaultsKey"

@implementation KNUser

//Singleton
+ (KNUser *) sharedInstance {
    
    static KNUser *instance = nil;
    
	static dispatch_once_t onceToken;
    
	dispatch_once(&onceToken, ^{
        if (instance == nil) {
	    	instance = [KNUser new];

            
        }
        
        
	});
    
	return instance;
}

- (id)init {
    
	self = [super init];
    
	if(self) {
        
        /// Listen for application state changes to save contents to disk before terminating or going to background
        addNotificationObserver(self, saveState:, UIApplicationWillResignActiveNotification, nil);
        addNotificationObserver(self, saveState:, UIApplicationWillTerminateNotification, nil);
        
        
        //initialize cosm service
        
         [[COSMAPI defaultAPI] setApiKey:@"igfescVEn9RuG-L1_1ZFdVUZ2vSSAKxOVzM5WmZkWFR0RT0g"];
        
	}
    
	return self;
}

- (void) dealloc {
        
	removeNotificationObserver(self);
}

- (NSString *)userId {
    
    return defaultsValue(kUserIdDefaultsKey);
}

- (NSString *)password {
    
    return [SFHFKeychainUtils getPasswordForUsername:self.userId andServiceName:kServiceDomainName error:nil];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public interface
- (BOOL)setUserId:(NSString *)userId andPassword:(NSString *)password error:(NSError **)error;
{
    NSString *currentUserId = self.userId;
    
    //  UserId and password cant be empty
    if([userId length] == 0 || [password length] == 0) {
        return NO;
    }
    
    if(currentUserId && ![userId isEqualToString:currentUserId]) {
        
        //  There is already any user in the app and we are trying to change userId -> we are switching the app for the another user
     //   FTDLOG(@"WARNING: UserId changed from \"%@\" to \"%@\"", currentUserId, userId);
        
      //  [[self class] purgeAllUserData];
    }
    
    //  Remove existing
    [SFHFKeychainUtils deleteItemForUsername:userId andServiceName:kServiceDomainName error:nil];
    
    //  Save new password
    if(![SFHFKeychainUtils storeUsername:userId andPassword:password forServiceName: kServiceDomainName updateExisting: NO error:error]) {
        
        //  If storing password fails, fail all settings userId/password combination
     //   FTDLOG(@"Error saving keychain item! %@", [*error localizedDescription]);
        return NO;
    }
    
    //  Save new user name
    setDefaultsValue(kUserIdDefaultsKey, userId);
    _email = userId;
    
    [self saveState:nil];
    
    return YES;
}


- (void) saveState: (NSNotification *) notification {
    
    //  Save user defaults
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

@end
