/*!
 @file Macros.h
 @abstract Definitions of global shortcut macros
 */

/*!
	 @definedblock Collection of shortcut macros to often accessed system components
	 @define NOW() Shortcut to [NSDate date]
	 @define canRespondToSelector(_class_, _selectorName_) Determines whether _class_ implements _selectorName
	 @define defaultsValue(__KEY__) Returns value for _KEY_ from standard user defaults
	 @define setDefaultsValue(__KEY__, __VALUE__) Sets Value for Key to standard user defaults
	 @define bundleVersion() Returns application bundle version string

 */
#define NOW() [NSDate date]

#define daysFromTimeInterval(__INTERVAL__) abs(ceil(__INTERVAL__ / 24 / 60 / 60))

#define canRespondToSelector(_class_, _selectorName_) [_class_ respondsToSelector: @selector(_selectorName_)]

#define defaultsValue(__KEY__) [[NSUserDefaults standardUserDefaults] objectForKey: (NSString *)__KEY__]

#define setDefaultsValue(__KEY__, __VALUE__) [[NSUserDefaults standardUserDefaults] setObject: __VALUE__ forKey: (NSString *)__KEY__]

#define bundleVersion() [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"]

//  Safe retrieving the values from the dicrtionary. If the dictionary value is NSNull, this macro returns regular nil
#define safeObjectForKey(__DICTIONARY__, __KEY__) (([__DICTIONARY__ objectForKey:__KEY__] == [NSNull null]) ? nil : [__DICTIONARY__ objectForKey:__KEY__])

//  Detecting device models
#define IS_4_INCH_DEVICE ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define IS_IPHONE  (([[[UIDevice currentDevice] model] isEqualToString:@"iPhone"]) || ([[[UIDevice currentDevice] model] isEqualToString:@"iPhone Simulator"]))
#define IS_IPOD     ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])
#define IS_IPHONE_5 (IS_IPHONE && IS_4_INCH_DEVICE)

#define LOCS(_a) NSLocalizedString(_a, nil)

#ifdef DEBUG
#    define DLog(...) NSLog(__VA_ARGS__)
#else
#    define DLog(...) /* */
#endif

/*!
 @macro addNotificationObserver
 @abstract Add observer to default notification center
 */
#define addNotificationObserver(_observer_, _selectorName_, _notificationName_, _object_) [[NSNotificationCenter defaultCenter] addObserver: _observer_ selector: @selector(_selectorName_) name: (NSString *)_notificationName_ object: _object_]

/*!
@macro postNotification
@abstract Post notification through default notification center
 */
#define postNotification(__NOTIFICATION__, __SENDER__, __USER_INFO__) [[NSNotificationCenter defaultCenter] postNotificationName: (NSString *)__NOTIFICATION__ object:__SENDER__ userInfo: __USER_INFO__]

/*!
@macro postNotification
@abstract Post notification through default notification center
 */
#define postNotificationName(__NOTIFICATION__, __SENDER__) [[NSNotificationCenter defaultCenter] postNotificationName: (NSString *)__NOTIFICATION__ object:__SENDER__]

/*!
@macro removeNotificationObserver
@abstract Remove observer from default notification center
 */
#define removeNotificationObserver(_observer_) [[NSNotificationCenter defaultCenter] removeObserver: _observer_]

#define FLURRY_TRACK(__SECTION_ID__) FLURRY_LOG(__SECTION_ID__, nil)

#define FLURRY_LOG(__SECTION_ID__, ...) [Flurry logEvent: __SECTION_ID__ withParameters: __VA_ARGS__]

#ifndef FTDLOG

#ifdef DEBUG

#define FTDLOG(xx, ...) TFLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#else

#define FTDLOG(xx, ...) ((void)0)

#endif

#endif

#define DEGREES_TO_RADIANS(x) (M_PI * x / 180.0)

//  RGB color
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f \
alpha:(a)]

#define ImageURLForImage(__IMAGE__) [[LMAPIClient sharedInstance] URLForImageNamed: __IMAGE__]

#define ImageURLForResizedImage(__IMAGE__, __SIZE__) [[LMAPIClient sharedInstance] URLForImageNamed:__IMAGE__ withSize:(NSUInteger)__SIZE__]


#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

