/**
 
 Created by Martin Dohnal.
 Copyright (c) 2012 eMan s.r.o. All rights reserved.
 
 */

#import "UIApplication+Paths.h"

@implementation UIApplication (Paths)

+(NSString*) pathForDirectoryType:(NSSearchPathDirectory)inDirectoryType{
	NSString* dirPath = [NSSearchPathForDirectoriesInDomains(inDirectoryType, NSUserDomainMask, YES) lastObject];
	
	if(inDirectoryType == NSApplicationSupportDirectory || inDirectoryType == NSCachesDirectory){
		NSString* applicationName = [[[NSBundle mainBundle] infoDictionary] valueForKey:(NSString *)kCFBundleNameKey];
		dirPath = [dirPath stringByAppendingPathComponent:applicationName];
	}
	
	NSFileManager* manager = [NSFileManager defaultManager];
	if([manager fileExistsAtPath:dirPath] == NO){
		[manager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:NULL];
	}
	
	return dirPath;
}

+(NSString*) pathForDocuments{
	return [UIApplication pathForDirectoryType:NSDocumentDirectory];
}

+(NSString*) pathForSupportFiles{
	return [UIApplication pathForDirectoryType:NSApplicationSupportDirectory];
}

+(NSString*) pathForTemporaryFiles{
	return [UIApplication pathForDirectoryType:NSCachesDirectory];
}

@end
