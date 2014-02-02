/**
 
 Created by Martin Dohnal.
 Copyright (c) 2012 eMan s.r.o. All rights reserved.
 
 */

#import "MKMapView+eMan.h"

MKCoordinateRegion MKCoordinateRegionInsetPercent(MKCoordinateRegion region, CGFloat percentX, CGFloat percentY) {
	MKCoordinateRegion insetRegion = region;
	insetRegion.span.latitudeDelta *=  1 + (percentY / 100);
	insetRegion.span.longitudeDelta *= 1 + (percentX / 100);
	
	return insetRegion;
}

MKCoordinateRegion MKCoordinateRegionInset(MKCoordinateRegion region, CLLocationDegrees latitudeDelta, CLLocationDegrees longitudeDelta) {
	MKCoordinateRegion insetRegion = region;
	insetRegion.span.latitudeDelta -= latitudeDelta;
	insetRegion.span.longitudeDelta -= longitudeDelta;
	
	return insetRegion;
}

@implementation MKMapView (eMan)

-(void) removeAllAnnotationsExceptUserLocation{
	NSMutableArray* anns = [self.annotations mutableCopy];
	if(self.userLocation != nil){
		[anns removeObject:self.userLocation];
	}
	[self removeAnnotations:anns];
	
#if !__has_feature(objc_arc)
	[anns release];
#endif
}

-(MKCoordinateRegion) regionThatFitsAnnotations:(NSArray *)annotations{
    int count = [annotations count];
	
	// bail if no annotations
    if ( count == 0) {
		return MKCoordinateRegionForMapRect(MKMapRectNull);
	}
    
    // convert NSArray of id <MKAnnotation> into an MKCoordinateRegion that can be used to set the map size
    // can't use NSArray with MKMapPoint because MKMapPoint is not an id
    MKMapPoint points[count]; //C array of MKMapPoint struct
    for( int i=0; i<count; i++ ) //load points C array by converting coordinates to points
    {
        CLLocationCoordinate2D coordinate = [(id <MKAnnotation>)[annotations objectAtIndex:i] coordinate];
        points[i] = MKMapPointForCoordinate(coordinate);
    }
	
    // create MKMapRect from array of MKMapPoint
    MKMapRect mapRect = [[MKPolygon polygonWithPoints:points count:count] boundingMapRect];
	
    // convert MKCoordinateRegion from MKMapRect
    MKCoordinateRegion region = MKCoordinateRegionForMapRect(mapRect);
	return region;
}

@end
