//
//  Measurement.m
//  kanarci
//
//  Created by Jan Remes on 14.03.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import "Measurement.h"

@implementation Measurement

@synthesize date,preciseValue,qualityString,thoroughfare,locality,country,longtitude,latitude,bucketValue,locationDataAvailable;





- (id)initWithCoder:(NSCoder *)aDecoder {
    
	self = [super init];
    
	if(self) {
        
        self.date = [aDecoder decodeObjectForKey:@"date"];
        self.bucketValue = [aDecoder decodeIntegerForKey:@"bucketValue"];
		self.preciseValue = [aDecoder decodeObjectForKey:@"preciseValue"];        
		self.qualityString = [aDecoder decodeObjectForKey:@"qualityString"];        
		self.locationDataAvailable = [aDecoder decodeBoolForKey:@"locationDataAvailable"];        
		self.thoroughfare = [aDecoder decodeObjectForKey:@"thoroughfare"];        
		self.locality = [aDecoder decodeObjectForKey:@"locality"];        
        self.country = [aDecoder decodeObjectForKey:@"country"];        
        self.longtitude = [aDecoder decodeFloatForKey:@"longtitude"];
        self.latitude = [aDecoder decodeFloatForKey:@"latitude"];        
        
	}
    
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.date forKey:@"date"];  
	[aCoder encodeInteger:self.bucketValue forKey:@"bucketValue"];
    [aCoder encodeObject:self.preciseValue forKey:@"preciseValue"];
    [aCoder encodeObject:self.qualityString forKey:@"qualityString"];
    [aCoder encodeBool:self.locationDataAvailable forKey:@"locationDataAvailable"];
    [aCoder encodeObject:self.thoroughfare forKey:@"thoroughfare"];
    [aCoder encodeObject:self.country forKey:@"country"];
    [aCoder encodeObject:self.locality forKey:@"locality"];
    [aCoder encodeFloat:self.longtitude forKey:@"longtitude"];
    [aCoder encodeFloat:self.latitude forKey:@"latitude"];

}


@end
