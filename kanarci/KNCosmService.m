//
//  KNCosmService.m
//  kanarci
//
//  Created by Jan Remes on 26.03.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import "KNCosmService.h"
#import "AFHTTPClient.h"
#import "KNFormatter.h"


@implementation KNCosmService


+ (KNCosmService *) sharedInstance {
    
    static KNCosmService *instance = nil;
    
	static dispatch_once_t onceToken;
    
	dispatch_once(&onceToken, ^{
        if (instance == nil) {
	    	instance = [KNCosmService new];
            
        }
        
	});    
	return instance;
}


#pragma mark -
#pragma mark - Public methods


+ (void) postMeasurementToCosm:(Measurement *) measurement {

    
//	NSString *APIPath;
    

    NSURL *url = [NSURL URLWithString:@"http://api.cosm.com/v2/feeds/122067/datastreams/prach_test/datapoints/?key=igfescVEn9RuG-L1_1ZFdVUZ2vSSAKxOVzM5WmZkWFR0RT0g"];
    
    
    AFHTTPClient *APIClient = [AFHTTPClient clientWithBaseURL:url];
    
    
   
    
	NSDictionary *data = @{@"datapoints" : @[@{@"at" : [KNFormatter RFCDateStringFromDate:measurement.date], @"value" : measurement.preciseValue}]};
    
	[APIClient setParameterEncoding:AFJSONParameterEncoding];
    
	[APIClient postPath:nil
	         parameters:data
			    success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    
                    NSLog(@"Datapoint successfully posted to cosm");
			    }
				failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"Posting to cosm failed");

				}];
}

@end
