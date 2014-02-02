/**
 
 Created by Martin Dohnal.
 Copyright (c) 2012 eMan s.r.o. All rights reserved.
 
 */

#import "UIImageView+eMan.h"

@implementation UIImageView (eMan)

+(UIImageView*) imageViewWithImageName:(NSString*)inName{
	UIImageView *imView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:inName]];

#if !__has_feature(objc_arc)
		[imView autorelease];
#endif

	return imView;
}


- (void) adjustImageViewFrameToImageSize
{
    
    
    CGSize imgSize      = self.image.size;
    CGSize frameSize    = self.frame.size;
    
    CGRect resultFrame;
    
    if(imgSize.width < frameSize.width && imgSize.height < frameSize.height)
    {
        resultFrame.size    = imgSize;
    }
    else
    {
        float widthRatio  = imgSize.width  / frameSize.width;
        float heightRatio = imgSize.height / frameSize.height;
        
        float maxRatio = MAX (widthRatio , heightRatio);
        //MDINFO(@"widthRatio = %.2f , heightRatio = %.2f , maxRatio = %.2f" , widthRatio , heightRatio , maxRatio);
        
        resultFrame.size = CGSizeMake(imgSize.width / maxRatio, imgSize.height / maxRatio);
    }
    
    resultFrame.origin  = CGPointMake(self.center.x - resultFrame.size.width/2 , self.center.y - resultFrame.size.height/2);
    
    [self setFrame:resultFrame];
}
@end
