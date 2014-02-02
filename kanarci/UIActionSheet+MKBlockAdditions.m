/**
 
 Created by Mugunth Kumar on 21/03/11. Customized by Martin Dohnal.
 Copyright 2011 Steinlogic All rights reserved.
 
 */

#import "UIActionSheet+MKBlockAdditions.h"

// Only one UIActionSheet can be displayed at a given time -> we can use static blocks
static DismissBlockActionSheet _dismissBlock;
static CancelBlock _cancelBlock;

@implementation UIActionSheet (MKBlockAdditions)

+(UIActionSheet*) actionSheetWithTitle:(NSString*) title
						  buttonTitles:(NSArray*) buttonTitles
					 cancelButtonTitle:(NSString*) cancelButtonTitle
							showInView:(UIView*) view
							 onDismiss:(DismissBlockActionSheet) dismissed
							  onCancel:(CancelBlock) cancelled{
	
    return [UIActionSheet actionSheetWithTitle:title
						destructiveButtonTitle:nil
								  buttonTitles:buttonTitles
							 cancelButtonTitle:cancelButtonTitle
									showInView:view
									 onDismiss:dismissed
									  onCancel:cancelled];
}

+ (UIActionSheet*) actionSheetWithTitle:(NSString*) title
				 destructiveButtonTitle:(NSString*) destructiveButtonTitle
						   buttonTitles:(NSArray*) buttonTitles
					  cancelButtonTitle:(NSString*) cancelButtonTitle
							 showInView:(UIView*) view
							  onDismiss:(DismissBlockActionSheet) dismissed
							   onCancel:(CancelBlock) cancelled{
	
    _cancelBlock  = [cancelled copy];
    _dismissBlock  = [dismissed copy];
	
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title
                                                             delegate:(id<UIActionSheetDelegate>)[self class]
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:destructiveButtonTitle
                                                    otherButtonTitles:nil];
    
    for(NSString* thisButtonTitle in buttonTitles){
        [actionSheet addButtonWithTitle:thisButtonTitle];
	}
	
	// add cancel button
    [actionSheet addButtonWithTitle:cancelButtonTitle];
    actionSheet.cancelButtonIndex = [buttonTitles count];
    if(destructiveButtonTitle){
        actionSheet.cancelButtonIndex ++;
	}
	
    if([view isKindOfClass:[UIView class]]){
        [actionSheet showInView:view];
	}
	else if([view isKindOfClass:[UITabBar class]]){
        [actionSheet showFromTabBar:(UITabBar*)view];
	}
	else if([view isKindOfClass:[UIBarButtonItem class]]){
        [actionSheet showFromBarButtonItem:(UIBarButtonItem*)view animated:YES];
	}
	
#if !__has_feature(objc_arc)
	[actionSheet autorelease];
#endif
	
	return actionSheet;
}

+(void) releaseBlocksIfNecessary{
#if !__has_feature(objc_arc)
	[_cancelBlock release];
	[_dismissBlock release];
#endif
	_cancelBlock = nil;
	_dismissBlock = nil;
}

#pragma mark - Action sheet delegate

+(void)actionSheet:(UIActionSheet*) actionSheet didDismissWithButtonIndex:(NSInteger) buttonIndex{
	if(buttonIndex == [actionSheet cancelButtonIndex]){
		if(_cancelBlock != nil){
			CancelBlock blockToRun = [_cancelBlock copy];
			[self releaseBlocksIfNecessary];
			blockToRun();
#if !__has_feature(objc_arc)
			[blockToRun release];
#endif
		}
	}
    else
    {
		if(_dismissBlock != nil){
			DismissBlockActionSheet blockToRun = [_dismissBlock copy];
			[self releaseBlocksIfNecessary];
			blockToRun(buttonIndex, actionSheet);
#if !__has_feature(objc_arc)
			[blockToRun release];
#endif
		}
	}
}

#pragma mark -

@end
