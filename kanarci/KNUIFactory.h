//
//  KNUIFactory.h
//  kanarci
//
//  Created by Jan Remes on 23.03.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNUIFactory : NSObject


/**
 Creates label with some default settings:
 Text alignment: Left
 Number of lines: 1
 Line break mode: truncating tail
 Adjusting size to min 2/3 of size
 Clear background color
 
 @param size Size of text
 @param bold Should be bold
 @returns Prepared label
 */
+ (UILabel *)labelWithFontSize:(CGFloat)size bold:(BOOL)bold;

@end
