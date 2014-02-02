/**
 
 Created by Martin Dohnal.
 Copyright (c) 2013 eMan s.r.o. All rights reserved.
 
 */

#import "NSData+eMan.h"

@implementation NSData (eMan)

unsigned char strToChar (char a, char b) {
	char encoder[3] = {'\0','\0','\0'};
	encoder[0] = a;
	encoder[1] = b;
	return (char) strtol(encoder, NULL, 16);
}

+(NSData*) dataWithHexaString:(NSString*)inString{
	const char * bytes = [inString cStringUsingEncoding:NSUTF8StringEncoding];
	NSUInteger length = strlen(bytes);
	unsigned char * r = (unsigned char *) malloc(length / 2 + 1);
	unsigned char * index = r;

	while ((*bytes) && (*(bytes +1))) {
		*index = strToChar(*bytes, *(bytes +1));
		index++;
		bytes+=2;
	}
	*index = '\0';

	NSData* result = [NSData dataWithBytes:r length:(length / 2)];
	free(r);

	return result;
}

- (NSString *)hexaString{
	NSMutableString *string = [NSMutableString string];

	// iterate through the bytes and convert to hex
	unsigned char *ptr = (unsigned char *)[self bytes];
	NSUInteger len = [self length];

	for (NSUInteger i=0; i < len; ++i) {
		// fixed from %0x
		[string appendString:[NSString stringWithFormat:@"%02x", ptr[i]]];
	}

	return string;
}

@end
