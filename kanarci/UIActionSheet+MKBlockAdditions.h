/**
 
 Block additions UIActionSheet
 
 Created by Mugunth Kumar on 21/03/11. Customized by Martin Dohnal.
 Copyright 2011 Steinlogic All rights reserved.
 
 */

#import <UIKit/UIKit.h>
#import "MKBlockAdditions.h"

@interface UIActionSheet (MKBlockAdditions) <UIActionSheetDelegate, UINavigationControllerDelegate>

/**
 Shows action sheet with title, given buttons in a given view. Blocks are used instead of a delegate.
 @param title title
 @param buttonTitles button titles
 @param cancelButtonTitle cancel button title or nil
 @param view view to show action sheet in
 @param dismissed dismissed block (called if button was not cancel button)
 @param cancelled cancelled block (called if button was a cancel button)
 @return UIActionSheet
 */
+(UIActionSheet*) actionSheetWithTitle:(NSString*) title
						  buttonTitles:(NSArray*) buttonTitles
					 cancelButtonTitle:(NSString*) cancelButtonTitle
							showInView:(UIView*) view
							 onDismiss:(DismissBlockActionSheet) dismissed
							  onCancel:(CancelBlock) cancelled;

/**
 Shows action sheet with title, given buttons in a given view. Blocks are used instead of a delegate.
 @param title title
 @param destructiveButtonTitle destuctive (red) button title or nil
 @param buttonTitles button titles
 @param cancelButtonTitle cancel button title or nil
 @param view view to show action sheet in
 @param dismissed dismissed block (called if button was not cancel button)
 @param cancelled cancelled block (called if button was a cancel button)
 @return UIActionSheet
 */
+(UIActionSheet*) actionSheetWithTitle:(NSString*) title
				destructiveButtonTitle:(NSString*) destructiveButtonTitle
						  buttonTitles:(NSArray*) buttonTitles
					 cancelButtonTitle:(NSString*) cancelButtonTitle
							showInView:(UIView*) view
							 onDismiss:(DismissBlockActionSheet) dismissed
							  onCancel:(CancelBlock) cancelled;

@end
