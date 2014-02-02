/**
 *
 Created by Mugunth Kumar on 21/03/11. Customized by Martin Dohnal.
 Copyright 2011 Steinlogic All rights reserved.
 
 */

#import "UIAlertView+MKBlockAdditions.h"
#import <objc/runtime.h>

static char DISMISS_IDENTIFER;
static char CANCEL_IDENTIFER;

@implementation UIAlertView (MKBlockAdditions)

@dynamic cancelBlock;
@dynamic dismissBlock;

- (void)setDismissBlock:(DismissBlockAlertView)dismissBlock{
    objc_setAssociatedObject(self, &DISMISS_IDENTIFER, dismissBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (DismissBlockAlertView)dismissBlock{
    return objc_getAssociatedObject(self, &DISMISS_IDENTIFER);
}

- (void)setCancelBlock:(CancelBlock)cancelBlock{
    objc_setAssociatedObject(self, &CANCEL_IDENTIFER, cancelBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CancelBlock)cancelBlock{
    return objc_getAssociatedObject(self, &CANCEL_IDENTIFER);
}


+ (UIAlertView*) alertViewWithTitle:(NSString*)title
							message:(NSString*)message
				  cancelButtonTitle:(NSString*)cancelButtonTitle
				  otherButtonTitles:(NSArray*)otherButtonTitles
						  onDismiss:(DismissBlockAlertView) dismissed
						   onCancel:(CancelBlock) cancelled {
	
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:[self class]
                                          cancelButtonTitle:cancelButtonTitle
                                          otherButtonTitles:nil];
    
    [alert setDismissBlock:dismissed];
    [alert setCancelBlock:cancelled];
    
    for(NSString *buttonTitle in otherButtonTitles){
        [alert addButtonWithTitle:buttonTitle];
	}
    
    [alert show];
	
#if !__has_feature(objc_arc)
	[alert autorelease];
#endif
	
    return alert;
}

+ (UIAlertView*) alertViewWithMessage:(NSString*)message okButtonTitle:(NSString*)okButtonTitle;{
	return [UIAlertView alertViewWithTitle:nil message:message okButtonTitle:okButtonTitle];
}

+ (UIAlertView*) alertViewWithTitle:(NSString*)title message:(NSString*)message okButtonTitle:(NSString*)okButtonTitle{
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
													message:message
												   delegate:nil
										  cancelButtonTitle:nil
										  otherButtonTitles:okButtonTitle, nil];
	
	[alert show];
	
#if !__has_feature(objc_arc)
	[alert autorelease];
#endif
	
	return alert;
}

#pragma mark - Alert view delegate

+ (void)alertView:(UIAlertView*) alertView didDismissWithButtonIndex:(NSInteger) buttonIndex {
    
	if(buttonIndex == [alertView cancelButtonIndex]){
		if (alertView.cancelBlock) {
            alertView.cancelBlock();
        }
	}
    else{
        if (alertView.dismissBlock) {
            alertView.dismissBlock(buttonIndex, alertView);
        }
    }
	
	alertView.dismissBlock = nil;
	alertView.cancelBlock = nil;
}

#pragma mark -

@end