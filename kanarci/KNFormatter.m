//
//  LMFormatter.m
//  Lamaica
//
//  Created by Lukas Kukacka on 1/16/13.
//  Copyright (c) 2013 Fuerte International Ltd. All rights reserved.
//

static NSNumberFormatter *numberFormatter = nil;

@implementation KNFormatter

+ (NSString *)formattedPrice:(float)price withCurrency:(NSString *)currency {

	NSString *output = nil;

	if(numberFormatter == nil) {

		numberFormatter = [NSNumberFormatter new];
		numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
	}

	output = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:price]];

	//  Append currency
	if(currency && [currency length] > 0) {
		output = [NSString stringWithFormat:@"%@ %@", output, currency];
	}

	return output;
}

+ (NSString *)formattedPriceVatIncluding:(float)vat withCurrency:(NSString *)currency {

	NSString *output = nil;

	if(numberFormatter == nil) {

		numberFormatter = [NSNumberFormatter new];
		numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
	}

	output = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:vat]];

	return [NSString stringWithFormat:NSLocalizedString(@"PRICE_VAT_INCLUDED", nil), (double)vat, currency];
}

+ (NSString *)commentsCountStringWithCount:(NSUInteger)count {

	if(count == 0) {
		return NSLocalizedString(@"COMMENTS_NO_COMMENT", nil);
	}
	else if(count == 1) {
		return [NSString stringWithFormat:NSLocalizedString(@"COMMENTS_ONE_COMMENT", nil), count];
	}
	else {
		return [NSString stringWithFormat:NSLocalizedString(@"COMMENTS_MULTIPLE_COMMENTS", nil), count];
	}
}

+ (NSString *)formattedAvailabilityStringWithDays:(int)days {

	NSString *abbreviation = (days > 1) ? NSLocalizedString(@"ABBREVIATION_FOR_DAYS", nil) : NSLocalizedString(@"ABBREVIATION_FOR_HOURS", nil);

	NSString *availabilityString = [NSString stringWithFormat:NSLocalizedString(@"AVAILABILITY_IN_DAYS", nil), (days > 1) ? days : 24, abbreviation];

	return availabilityString;
}

+ (NSString *)formattedItemsInStockStringWithItems:(NSUInteger)numberOfItems {

	if(numberOfItems == 0) {
		return NSLocalizedString(@"STOCK_AVAILABLE_NO_ITEM", nil);
	}
	else if(numberOfItems == 1) {
		return [NSString stringWithFormat:NSLocalizedString(@"STOCK_AVAILABLE_ONE_ITEM", nil), numberOfItems];
	}
	else {
		return [NSString stringWithFormat:NSLocalizedString(@"STOCK_AVAILABLE_ONE_MULTIPLE", nil), numberOfItems];
	}
}

+ (NSString *)formattedDate:(NSDate *)date {

	static NSDateFormatter *dateFormatter = nil;

	if(dateFormatter == nil) {

		dateFormatter = [NSDateFormatter new];

		[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
		[dateFormatter setTimeStyle:NSDateFormatterShortStyle];
	}

	return [dateFormatter stringFromDate:date];
}

+ (NSString *)formattedDateShortStyle:(NSDate *)date {

	static NSDateFormatter *dateFormatter = nil;

	if(dateFormatter == nil) {

		dateFormatter = [NSDateFormatter new];

		[dateFormatter setDateStyle:NSDateFormatterMediumStyle];

	}

	return [dateFormatter stringFromDate:date];
}

+ (NSString *)RFCDateStringFromDate:(NSDate *)date {

	static NSDateFormatter *rfcDateFormatter = nil;

	if(rfcDateFormatter == nil) {

		NSLocale *posixLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
		NSString *rfcDateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ"; //@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'";

		rfcDateFormatter = [NSDateFormatter new];

		[rfcDateFormatter setLocale:posixLocale];
		[rfcDateFormatter setDateFormat:rfcDateFormat];
		//[rfcDateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	}

	return [rfcDateFormatter stringFromDate:date];
}

+ (NSDate *)dateFromRFCDateString:(NSString *)rfc3339DateString {

	static NSDateFormatter *rfcDateFormatter = nil;

	if(rfcDateFormatter == nil) {

		NSLocale *posixLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
		NSString *rfcDateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ"; //@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'";

		rfcDateFormatter = [NSDateFormatter new];

		[rfcDateFormatter setLocale:posixLocale];
		[rfcDateFormatter setDateFormat:rfcDateFormat];
		//[rfcDateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	}

	NSDate *date = nil;
	NSError *error = nil;

	[rfcDateFormatter getObjectValue:&date forString:rfc3339DateString range:nil error:&error];

	return date; //[rfcDateFormatter dateFromString:rfc3339DateString];
}

@end
