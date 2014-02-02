/**
 
 MKMapView utility category
 
 Created by Martin Dohnal.
 Copyright (c) 2012 eMan s.r.o. All rights reserved.
 
 */

#import <MapKit/MapKit.h>

MKCoordinateRegion MKCoordinateRegionInset(MKCoordinateRegion region, CLLocationDegrees latitudeDelta, CLLocationDegrees longitudeDelta);
MKCoordinateRegion MKCoordinateRegionInsetPercent(MKCoordinateRegion region, CGFloat percentX, CGFloat percentY);

@interface MKMapView (eMan)

-(void) removeAllAnnotationsExceptUserLocation;
-(MKCoordinateRegion) regionThatFitsAnnotations:(NSArray *)annotations;


@end
