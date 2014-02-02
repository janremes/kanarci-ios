/**
 
 Created by Martin Dohnal.
 Copyright (c) 2012 eMan s.r.o. All rights reserved.
 
 */

#import "UISearchBar+eMan.h"

@implementation UISearchBar (eMan)

-(void) removeBackground{
	// only hides background view on top (cannot be customized in iOS < 5)
	for (UIView *subview in self.subviews){
		if(CGRectEqualToRect(self.bounds, subview.frame) || [NSStringFromClass([subview class]) isEqualToString:@"UISearchBarBackground"]){
			[subview setAlpha:0];
            break;
		}
    }
}

@end
