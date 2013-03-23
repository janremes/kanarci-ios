//
//  MapViewController.h
//  kanarci
//
//  Created by Jan Remes on 22.03.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController {
    
    MKCoordinateRegion lastCoordination;

}

@property (nonatomic, strong) NSArray *annotations;
@property(readwrite, assign) MKCoordinateRegion lastCoordination;

@end
