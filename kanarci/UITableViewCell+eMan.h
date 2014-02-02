/**
 
 Utility category for TableViewCells
 
 Created by Martin Dohnal on 12.03.13.
 Copyright (c) 2013 eMan s.r.o. All rights reserved.
 
 */

#import <UIKit/UIKit.h>

@interface UITableViewCell (eMan)

/// Returns loaded nib with the same name as the class
+(UINib*) nib;

/// Returns default reuse identifier with the same name as the class
+(NSString*) defaultReuseIdentifier;

/// Returns instance of nib
+(id) nibInstance;

@end
