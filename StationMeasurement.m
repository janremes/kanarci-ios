//
//  StationMeasurement.m
//  SmogAlarm
//
//  Created by Vojtech Vrbka on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StationMeasurement.h"
#import "Station.h"
@implementation StationMeasurement
@synthesize name,value,station;

+(StationMeasurement*)stationMeasurementForName:(NSString*)name andValue:(NSDecimalNumber*)value andStation:(Station*)station {
    StationMeasurement *measurement = [[StationMeasurement alloc] init];
    measurement.name = name;
    measurement.value = value;
    measurement.station = station;                                
    return measurement;
}

+(NSString*)titleForMeasurement:(NSString*)measurement {
    NSMutableDictionary *titles = [[NSMutableDictionary alloc] init];
    [titles setValue:@"OXID SIŘIČITÝ" forKey:@"SO2"];
    [titles setValue:@"OXID DUSIČITÝ" forKey:@"NO2"];
    [titles setValue:@"OXID UHELNATÝ" forKey:@"CO"];
    [titles setValue:@"OZON" forKey:@"O3"];
    [titles setValue:@"PRACH" forKey:@"PM10"];
    return [titles objectForKey:measurement];
}

-(NSString*)getTitle {
return [StationMeasurement titleForMeasurement:self.name];
}


-(BOOL)haveIndex {
    return ( [name isEqualToString:@"SO2"] || [name isEqualToString:@"NO2"] || [name isEqualToString:@"O3"] || [name isEqualToString:@"PM10"]);
}

+(NSString*)descriptionForMeasurement:(NSString*)measurement {
    NSMutableDictionary *titles = [[NSMutableDictionary alloc] init];
    [titles setValue:@"Oxid siřičitý je jedním ze dvou oxidů síry. Je to bezbarvý, štiplavě páchnoucí, jedovatý plyn. \nPůsobí dráždivě zejména na horní cesty dýchací, dostavuje se kašel, v těžších případech může vzniknout až edém plic. Menší koncentrace vyvolávají záněty průdušek a astma.Chronická expozice oxidu siřičitému negativně ovlivňuje krvetvorbu, způsobuje rozedmu plic, poškozuje srdeční sval, negativně působí na menstruační cyklus. <a href='http://cs.wikipedia.org/wiki/Oxid_siřičitý'>[wikipedia]</a>" forKey:@"SO2"];
    [titles setValue:@"V plynném stavu jde o červenohnědý, agresivní, prudce jedovatý plyn, v kapalném stavu je to žlutohnědá látka, která tuhne na bezbarvé krystaly.\nV ovzduší patří oxid dusičitý k plynům, které způsobují kyselé deště. Oxid dusičitý je pohlcován hlenem dýchacích cest z 80 až 90 procent. Způsobuje záněty dýchacích cest od lehkých forem až po edém plic. <a href='http://cs.wikipedia.org/wiki/Oxid_dusičitý'>[wikipedia]</a>" forKey:@"NO2"];
    [titles setValue:@"Oxid uhelnatý (starší terminologií kysličník uhelnatý) je bezbarvý plyn bez chuti a zápachu, lehčí než vzduch, nedráždivý. \nVzhledem k jedovatosti je jednou z významných znečišťujících latek. Vzniká při nedokonalém spalování uhlíku a organických látek, je emitován např. automobily, lokálními topeništi, energetickým a metalurgickým průmyslem. <a href='http://cs.wikipedia.org/wiki/Oxid_uhelnatý'>[wikipedia]</a>" forKey:@"CO"];
    [titles setValue:@"Ozon je minoritní složkou nízké atmosféry, zejména fotochemického smogu. Troposférický ozon vzniká složitými chemickými reakcemi oxidů dusíku s těkavými organickými sloučeninami za horkých letních dnů a bezvětří, a to především v městských a průmyslových oblastech. \nVdechování ozonu vyvolává pokles kapacity plic v závislosti na jeho koncentraci a na hloubce dýchání. <a href='http://cs.wikipedia.org/wiki/Ozon'>[wikipedia]</a>" forKey:@"O3"];
    [titles setValue:@"Pevné prachové částice jsou drobné pevné či kapalné částice rozptýlené ve vzduchu, které jsou tak malé, že mohou být unášeny vzduchem. Znečištění prachovými částice v současností patří k hlavním problémům kvality ovzduší v České republice. Představují významné riziko pro lidské zdraví a pocházejí hlavně ze spalovacích procesů v energetice, vytápění domácností a v dopravě. <a href='http://cs.wikipedia.org/wiki/Pevné_částice'>[wikipedia]</a>" forKey:@"PM10"];
    return [titles objectForKey:measurement];
}

-(NSString*)getDescription {
    return [StationMeasurement descriptionForMeasurement:self.name];
}


+(NSArray*)qualityLevelsForMeasurement:(NSString*)measurement {
    NSArray *levels;
    if([measurement isEqualToString:@"SO2"]) {    
       levels  = [NSArray arrayWithObjects:[NSNumber numberWithInt:25],[NSNumber numberWithInt:50],[NSNumber numberWithInt:120],[NSNumber numberWithInt:350],[NSNumber numberWithInt:500], nil];
    } else if ([measurement isEqualToString:@"NO2"]) {
       levels  = [NSArray arrayWithObjects:[NSNumber numberWithInt:25],[NSNumber numberWithInt:50],[NSNumber numberWithInt:100],[NSNumber numberWithInt:200],[NSNumber numberWithInt:400], nil];       
    } else if ([measurement isEqualToString:@"CO"]) {
       levels  = [NSArray arrayWithObjects:[NSNumber numberWithInt:1000],[NSNumber numberWithInt:2000],[NSNumber numberWithInt:4000],[NSNumber numberWithInt:10000],[NSNumber numberWithInt:30000], nil];           
    } else if ([measurement isEqualToString:@"O3"]) {   
       levels  = [NSArray arrayWithObjects:[NSNumber numberWithInt:33],[NSNumber numberWithInt:65],[NSNumber numberWithInt:120],[NSNumber numberWithInt:180],[NSNumber numberWithInt:240], nil];           
    } else if ([measurement isEqualToString:@"PM10"]) {
       levels  = [NSArray arrayWithObjects:[NSNumber numberWithInt:20],[NSNumber numberWithInt:40],[NSNumber numberWithInt:70],[NSNumber numberWithInt:90],[NSNumber numberWithInt:180], nil];                   
    }
    return levels;
}
-(NSArray*)getQualityLevels {
    return [StationMeasurement qualityLevelsForMeasurement:self.name];
}


-(NSString*)getLevelForSlider:(int)quality {
    NSString *formatedString;
    NSArray *levels = [StationMeasurement qualityLevelsForMeasurement:self.name];
    int level = [[levels objectAtIndex:(quality-1)] intValue];    
    if(level >= 1000) {
        if( level/1000.0 == round(level/1000.0) ) {
            formatedString = [NSString stringWithFormat:@"%2.0fk",level/1000.0];      
        } else {
            formatedString = [NSString stringWithFormat:@"%2.1fk",level/1000.0];      
        }                
    } else {
        formatedString = [NSString stringWithFormat:@"%d",level];   
    }
    return formatedString;
}

-(NSString*)getFormatedValue {
    float valueLocal = [self.value floatValue];
    NSString *formatedString; 
    // its int ?
    if(valueLocal == round(valueLocal)) {
        formatedString = [NSString stringWithFormat:@"%d",(int)valueLocal];
    } else if (valueLocal >= 1000) {
        if( valueLocal/1000.0 == round(valueLocal/1000.0) ) {
            formatedString = [NSString stringWithFormat:@"%2.0fk",valueLocal/1000.0];      
        } else {
            formatedString = [NSString stringWithFormat:@"%2.2fk",valueLocal/1000.0];      
        }    
    } else {
        formatedString = [NSString stringWithFormat:@"%2.1f",valueLocal];
    }
    NSLog(@"%@",formatedString);
    formatedString = [formatedString stringByReplacingOccurrencesOfString:@"." withString:@","];
//    formatedString = @"0.55k";
    return formatedString;
}

// todo refactoring
-(int) getQuality {
    if(name == nil) {
        return 0;
    }
    
    float valueLocal = [self.value floatValue];
    int quality = 0; float lastValue;
    for(NSNumber *level in [self getQualityLevels]) {
        quality++;
        if(valueLocal < [level floatValue]) return quality;
        lastValue = [level floatValue];
    }
    if(valueLocal > lastValue) {
        return 6;
    }
    
    
    //  NSLog(@"hoo dno taaa");
    //  NSLog([NSString stringWithFormat:@"hodnota %3.2f",value]);
//    if([name isEqualToString:@"SO2"]) {
//        if( value >= 0  && value < 25 ) { return 1; }
//        else if ( value >= 25  && value < 50 ) { return 2; }
//        else if ( value >= 50 && value < 120 ) { return 3; }
//        else if ( value >= 120 && value < 350 ) { return 4; }
//        else if ( value >= 350 && value < 500 ) { return 5; } 
//        else if ( value >= 500 ) { return 6; }
//    } else if ([name isEqualToString:@"NO2"]) {
//        if( value >= 0 && value < 25 ) { return 1; }
//        else if ( value >= 25 && value < 50 ) { return 2; }
//        else if ( value >= 50 && value < 100 ) { return 3; }
//        else if ( value >= 100 && value < 200 ) { return 4; }
//        else if ( value >= 200 && value < 400 ) { return 5; } 
//        else if ( value >= 400 ) { return 6; }        
//    } else if ([name isEqualToString:@"CO"]) {
//        if( value >= 0 && value < 1000 ) { return 1; }
//        else if ( value >= 1000 && value < 2000 ) { return 2; }
//        else if ( value >= 2000 && value < 4000 ) { return 3; }
//        else if ( value >= 4000 && value < 10000 ) { return 4; }
//        else if ( value >= 10000 && value < 30000 ) { return 5; } 
//        else if ( value >= 30000 ) { return 6; }        
//    } else if ([name isEqualToString:@"O3"]) {
//        if( value >= 0 && value < 33 ) { return 1; }
//        else if ( value >= 33 && value < 65 ) { return 2; }
//        else if ( value >= 65 && value < 120 ) { return 3; }
//        else if ( value >= 120 && value < 180 ) { return 4; }
//        else if ( value >= 180 && value < 240 ) { return 5; } 
//        else if ( value >= 240 ) { return 6; }        
//    } else if ([name isEqualToString:@"PM10"]) {
//        if( value >= 0 && value < 20 ) { return 1; }
//        else if ( value >= 20 && value < 40 ) { return 2; }
//        else if ( value >= 40 && value < 70 ) { return 3; }
//        else if ( value >= 70 && value < 90 ) { return 4; }
//        else if ( value >= 90 && value < 180 ) { return 5; } 
//        else if ( value >= 180 ) { return 6; }        
//    }
    return 0;
}

@end
