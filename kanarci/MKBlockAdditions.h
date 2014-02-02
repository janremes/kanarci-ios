/**

 Block additions for NSObject, UIActionSheet, UIAlertView.

 Supports both ARC and non-ARC modes.

 Created by Mugunth Kumar on 21/03/11. Customized by Martin Dohnal.
 Copyright 2011 Steinlogic All rights reserved.

 */

#import <UIKit/UIKit.h>

typedef void (^VoidBlock)();

typedef void (^DismissBlockActionSheet)(int buttonIndex, UIActionSheet* actionSheet);
typedef void (^DismissBlockAlertView)(int buttonIndex, UIAlertView* alertView);
typedef void (^CancelBlock)();

#import "NSObject+MKBlockAdditions.h"
#import "UIActionSheet+MKBlockAdditions.h"
#import "UIAlertView+MKBlockAdditions.h"