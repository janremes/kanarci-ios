/**
 
 Utility class for UIImageView
 
 Created by Martin Dohnal.
 Copyright (c) 2012 eMan s.r.o. All rights reserved.
 
 */

#import <UIKit/UIKit.h>

@interface UIImageView (eMan)

/**
 Creates image view with image created from given image name.
 
 @param inName name of the image in resource bundle
 @return created UIImageView
 */
+(UIImageView*) imageViewWithImageName:(NSString*)inName;

/**
 Adjust UIImageView frame to fit image without gaps. Useful when image has view mode Aspect fit.
 
 */
- (void) adjustImageViewFrameToImageSize;

@end
