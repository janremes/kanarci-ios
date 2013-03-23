//
//  Station.m
//  SmogAlarm
//
//  Created by Vojtech Vrbka on 1/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Station.h"
#import "StationMeasurement.h"


@interface NSString (ReplaceExtensions)
- (NSString *)stringByReplacingStringsFromDictionary:(NSDictionary *)dict;
@end

@implementation NSString (ReplaceExtensions)
- (NSString *)stringByReplacingStringsFromDictionary:(NSDictionary *)dict
{
    NSMutableString *string = [self mutableCopy];
    for (NSString *target in dict) {
        [string replaceOccurrencesOfString:target withString:[dict objectForKey:target] 
                                   options:0 range:NSMakeRange(0, [string length])];
    }
    return string;
}
@end




@implementation Station
// @class StationMeasurement;
@synthesize code = _code;
@synthesize name = _name;
@synthesize date = _date;
@synthesize location,measurements,totalQuality,number;


-(id)initWithDictionaryData:(NSDictionary *)dictionary {
   	self = [super init];
    
	if(self) {
      
        _code = (NSString*)[dictionary objectForKey:@"code"];
        _name = (NSString*)[dictionary objectForKey:@"name"];
        
        // location
        CLLocationDegrees latitude = [[dictionary objectForKey:@"latitude"] doubleValue];
        CLLocationDegrees longitude = [[dictionary objectForKey:@"longitude"] doubleValue];
        self.location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
        self.measurements = [[NSMutableDictionary alloc] init];
        [((NSDictionary*)[dictionary objectForKey:@"measurement"]) enumerateKeysAndObjectsUsingBlock:^(id dictName, id value, BOOL *stop) {
            [self.measurements setValue:[StationMeasurement stationMeasurementForName:dictName andValue:value andStation:self] forKey:dictName];
        }];
        
        self.totalQuality = (NSNumber*)[dictionary objectForKey:@"hourly_index"];
        if([self.totalQuality intValue] == -1) {
            self.totalQuality = 0;
        }
        
        
        
    }
    
  return self;  
}


-(BOOL)isEqualToStation:(Station*)station {
    return [self.code isEqualToString:station.code];
}

-(NSString *)qualityString {
    NSArray *qualities = [[NSArray alloc] initWithObjects:@"chybí údaj",@"velmi dobrá",@"dobrá",@"uspokojivá",@"vyhovující",@"špatná",@"velmi špatná", nil];

    return [qualities objectAtIndex:[self.totalQuality intValue] ];
}

+(UIColor *)getColorForQuality:(int)quality {
    NSArray *colors = [NSArray arrayWithObjects:[UIColor colorWithRed:154.0f/255.0f green:154.0f/255.0f blue:154.0f/255.0f alpha:1.0f],
                       [UIColor colorWithRed:199.0f/255.0f green:234.0f/255.0f blue:251.0f/255.0f alpha:1.0f],
                       [UIColor colorWithRed:141.0f/255.0f green:211.0f/255.0f blue:165.0f/255.0f alpha:1.0f],
                       [UIColor colorWithRed:249.0f/255.0f green:234.0f/255.0f blue:31.0f/255.0f alpha:1.0f],
                       [UIColor colorWithRed:242.0f/255.0f green:168.0f/255.0f blue:50.0f/255.0f alpha:1.0f],
                       [UIColor colorWithRed:215.0f/255.0f green:119.0f/255.0f blue:123.0f/255.0f alpha:1.0f],
                       [UIColor colorWithRed:137.0f/255.0f green:87.0f/255.0f blue:88.0f/255.0f alpha:1.0f],
                       nil];
    return [colors objectAtIndex:quality];
}

-(UIColor *)qualityColor {
    return [Station getColorForQuality:[self.totalQuality intValue]] ;
}

-(void)initOrder {
    NSArray *preferredOrder = [NSArray arrayWithObjects:@"PM10",@"SO2",@"NO2",@"CO",@"O3", nil];
    NSLog(@"init order");
    measurementsTableOrder = [[NSMutableArray alloc] initWithCapacity:[measurements count]];
    for(NSString *obj in preferredOrder) {
        if( [measurements objectForKey:obj] != nil ) {
            [measurementsTableOrder addObject:obj];
            
        }
    }
}

-(NSString*)getShortName {
//    NSDictionary *replacements = [NSDictionary dictionaryWithObjectsAndKeys:
//                                 @"", @"Ostrava - ",
//                                 @"", @"(hot spot)",
//                                  @"", @"Brno - ",
//                                  @"", @"Praha - ",
//                                  @"HR.KRÁL.", @"Hradec Králové - ",
//                                  @"Rieg.", @"Riegrovy",
//                                  @"", @"Tobolka - ",
//                                  @"", @"Ústí n.L. - ",
//                                  @"", @"Plzeň - ",                                                                    
//                                 nil];
    
    NSDictionary *replacements = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"", @"Ostrava - ",
                                  @"", @"(hot spot)",
                                  @"", @"Brno - ",
                                //  @"", @"Praha - ",
                                  @"HR.KRÁL. -", @"Hradec Králové - ",
                                  @"Rieg.", @"Riegrovy",
                                  @"", @"Tobolka - ",
                                  @"", @"Ústí n.L. - ",
                                  @"", @"Plzeň - ",                                                                    
                                  nil];
   // NSLog(self.name);
    return [self.name stringByReplacingStringsFromDictionary:replacements];
}


-(NSString*)nameForTitle {
 //   NSLog(self.name);
    NSDictionary *replacements = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"", @"(hot spot)",
                                  @"Hr.Král.", @"Hradec Králové",
                                  @"Mar. Hory", @"Mariánské Hory",
                                  @"Českobrat.", @"Českobratrská",
                                  @"Radvanice", @"Radvanice ZÚ",
                                  @"Čert. sch.", @"Čertovy schody",
                                  @"nám. Rep.", @"nám. Republiky",
                                  @"Pardubice - Dukla", @"Pardubice Dukla",
                                  @"Plzeň - mobil", @"Plzeň  -  mobil",
                                  @"", @"",
                                  nil];
    return [self.name stringByReplacingStringsFromDictionary:replacements];
}
-(NSString*)nameForTable {
    NSDictionary *replacements = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"", @"(hot spot)",
                                  @"Hr.Král.", @"Hradec Králové",
                                  @"Pardubice - Dukla", @"Pardubice Dukla",
                                  @"Plzeň - mobil", @"Plzeň  -  mobil",
                                  @"", @"",
                                  @"", @"",
                                  nil];
    return [self.name stringByReplacingStringsFromDictionary:replacements];    
}

-(StationMeasurement*) getMeasurementForTable:(int)index{
    if(measurementsTableOrder == nil || [measurementsTableOrder count] == 0) {
        [self initOrder];
    }
  //  NSLog([NSString stringWithFormat:@"getting measurement for index %d measurement %@ ",index,[measurementsTableOrder objectAtIndex:index]]);
    return [self getMeasurement:[measurementsTableOrder objectAtIndex:index]];
}

-(StationMeasurement*)getMeasurement:(NSString*)measurement {
 //   NSLog(@"getMeasurement");
 //   return nil;
//    NSLog([NSString stringWithFormat:@"hledam measurement %@",measurements]);
    return (StationMeasurement*)[measurements objectForKey:measurement];
}




-(UIImage *)mapPinImage {
    NSString *imageName = [[NSString alloc] initWithFormat:@"mapPin%d.png",[self.totalQuality intValue]];
    return [UIImage imageNamed:imageName]; 
}

-(NSString *)toString {
    return [[NSString alloc] initWithFormat:@"Station object [code:%@, name:%@, quality:%d]",self.name,self.code,[self.totalQuality intValue]];
}

@end
