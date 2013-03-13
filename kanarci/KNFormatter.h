//
//  LMFormatter.h
//  Lamaica
//
//  Created by Lukas Kukacka on 1/16/13.
//  Copyright (c) 2013 Fuerte International Ltd. All rights reserved.
//
//  Various content formatters belongs here

#import <Foundation/Foundation.h>

@interface KNFormatter : NSObject

/**
	Returns formatted price string with the given currency.
    Example from design: 6 357,50 Kč
	@param price Price
	@param currency Currency string. If set, its appended to the end after space. If not set, is not appended
	@returns Formatted price string
 */
+ (NSString *)formattedPrice:(float)price withCurrency:(NSString *)currency;

+ (NSString *)formattedPriceVatIncluding:(float)price withCurrency:(NSString *)currency;

/**
	Returns formatted "number of comments" string in human format with the given number of comments.
    Example: No comment, 1 comment, 2 comments
	@param count Number of comments
	@returns Formatted string
 */
+ (NSString *)commentsCountStringWithCount:(NSUInteger)count;

+ (NSString *)formattedAvailabilityStringWithDays:(int)days;

/**
    Returns formatted "number of available in the stock" string in human format with the given number of items
    Example: Not available in stock, 1 item in stock, 2 items in stock ...
	@param numberOfItems Number of items
	@returns Formatted string
 */
+ (NSString *)formattedItemsInStockStringWithItems:(NSUInteger)numberOfItems;


+ (NSString *)formattedDate:(NSDate *)date;

/**
    Returns formatted date in medium style without time. Etc: Jan 31,2013
    @param date Date to be formated
    @returns Formatted date

*/
+ (NSString *)formattedDateShortStyle:(NSDate *)date;

+ (NSString *)RFCDateStringFromDate:(NSDate *)date;

+ (NSDate *)dateFromRFCDateString:(NSString *)rfc3339DateString;

@end
