/**
 
 Created by Martin Dohnal on 27.02.13.
 Copyright (c) 2013 eMan s.r.o. All rights reserved.
 
 */

#import "UIFont+eMan.h"

@implementation UIFont (eMan)

+(NSArray*) availableFontNames{
	NSMutableArray* allNames = [NSMutableArray array];
	for(NSString* familyName in [UIFont familyNames]){
		NSArray* fontNames = [UIFont fontNamesForFamilyName:familyName];
		[allNames addObjectsFromArray:fontNames];
	}
	return allNames;
}

@end
