/**
 
 Block additions for UIAlertView
 
 Created by Mugunth Kumar on 21/03/11. Customized by Martin Dohnal.
 Copyright 2011 Steinlogic All rights reserved.
 
 */

#import <Foundation/Foundation.h>
#import "MKBlockAdditions.h"

@interface UIAlertView (MKBlockAdditions) <UIAlertViewDelegate>

/// dismiss block of alert view
@property (nonatomic, copy) DismissBlockAlertView dismissBlock;

/// cancel block of alert view
@property (nonatomic, copy) CancelBlock cancelBlock;

/**
 Shows alert with message and one button.
 @param message message
 @param okButtonTitle button title
 @return UIAlertView
 */
+ (UIAlertView*) alertViewWithMessage:(NSString*)message
						okButtonTitle:(NSString*)okButtonTitle;

/**
 Shows alert with title, message and one button.
 @param title title
 @param message message
 @param okButtonTitle button title
 @return UIAlertView
 */
+ (UIAlertView*) alertViewWithTitle:(NSString*)title
                            message:(NSString*)message
					  okButtonTitle:(NSString*)okButtonTitle;

/**
 Shows alert with title, message and given button. Blocks are used instead of a delegate.
 @param title title
 @param message message
 @param cancelButtonTitle cancel button title or nil
 @param otherButtonTitles other button titles or nil
 @param dismissed dismissed block (called if button was not cancel button)
 @param cancelled cancelled block (called if button was a cancel button)
 @return UIAlertView
 */
+ (UIAlertView*) alertViewWithTitle:(NSString*)title
                            message:(NSString*)message
                  cancelButtonTitle:(NSString*)cancelButtonTitle
                  otherButtonTitles:(NSArray*)otherButtonTitles
                          onDismiss:(DismissBlockAlertView) dismissed
                           onCancel:(CancelBlock) cancelled;



@end
