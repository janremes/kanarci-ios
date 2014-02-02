/**
 
 Paths category for UIApplication. Simplifies getting Documents, Caches, etc. directories.
 
 Created by Martin Dohnal.
 Copyright (c) 2012 eMan s.r.o. All rights reserved.
 
 */

#import <UIKit/UIKit.h>

@interface UIApplication (Paths)

/**
 Document directory path (creates directory if necessary)
 @return Document directory path
 */
+(NSString*) pathForDocuments;

/**
 Library directory path with app name as last directory (creates directory if necessary)
 @return Library directory path
 */
+(NSString*) pathForSupportFiles;

/**
 Cache directory path with app name as last directory (creates directory if necessary)
 @return Cache directory path
 */
+(NSString*) pathForTemporaryFiles;

/**
 Gets Directory path for given directory type
 @param inDirectoryType directory type
 @return directory path (created if necessary)
 */
+(NSString*) pathForDirectoryType:(NSSearchPathDirectory)inDirectoryType;

@end
