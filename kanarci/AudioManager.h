//
//  AudioManager.h
//  kanarci
//
//  Created by Jan Remes on 21.04.14.
//  Copyright (c) 2014 Jan Remes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioManager : NSObject
+ (AudioManager *) sharedInstance ;
-(void) setup;
@end
