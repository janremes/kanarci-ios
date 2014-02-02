/**
 
 Created by Martin Dohnal on 20.04.13.
 Copyright (c) 2013 eMan s.r.o. All rights reserved.
 
 */

#import "UICollectionViewCell+eMan.h"

@implementation UICollectionViewCell (eMan)

+(UINib*) nib{
	return [UINib nibWithNibName:NSStringFromClass(self) bundle:nil];
}

+(NSString*) defaultReuseIdentifier{
	return NSStringFromClass(self);
}

+(id) nibInstance
{
	UINib* nib = [self nib];
	NSArray* views = [nib instantiateWithOwner:nil options:nil];
	return [views objectAtIndex:0];
}

@end
