//
//  MeasureData.m
//  kanarci
//
//  Created by Jan Remes on 27.03.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import "KNMeasureDataDocument.h"

@implementation KNMeasureDataDocument
@synthesize documentData;

// Called whenever the application reads data from the file system
- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName
                   error:(NSError **)outError
{
    
    if ([contents length] > 0) {
        self.documentData = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:contents]] ;
    } else {

        self.documentData = [[NSMutableArray alloc] init];
    }
    
    return YES;
}

// Called whenever the application (auto)saves the content of a note
- (id)contentsForType:(NSString *)typeName error:(NSError **)outError
{
    
    if ([self.documentData count] == 0) {
        
        self.documentData = [[NSMutableArray alloc] init];
    }
    
    return [NSKeyedArchiver archivedDataWithRootObject:self.documentData];
    
}



-(NSString *)description {
    return [NSString stringWithFormat:@"Data desc cound : %d" , [documentData count]];
}

@end
