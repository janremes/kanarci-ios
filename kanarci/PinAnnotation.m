//
//  PinAnnotation.m
//  kanarci
//
//  Created by Jan Remes on 27.09.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import "PinAnnotation.h"

@implementation PinAnnotation




- (id)initWithTitle:(NSString *)ttl andCoordinate:(CLLocationCoordinate2D)c2d {
    if ((self = [super init])) {
        self.title = ttl;
        self.coordinate = c2d;
    }
    return self;
}


@end
