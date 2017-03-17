//
//  HYCrumbPath.m
//  EasyMap
//
//  Created by hyyy on 2017/3/16.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYCrumbPath.h"
#import <pthread.h>

#define MINIMUM_DELTA_METERS 10.0

@interface HYCrumbPath(){
    MKMapPoint *_pointBuffer;
    NSUInteger _pointCount;
    NSUInteger _pointBufferCapacity;
    
    pthread_rwlock_t _rwLock;
}
@property (nonatomic, readwrite) MKMapRect boundingMapRect;

@end
@implementation HYCrumbPath

- (id)initWithCenterCoordinate:(CLLocationCoordinate2D)cooridinate {
    self = [super init];
    if (self) {
        _pointBufferCapacity = 1000;
        _pointBuffer = malloc(sizeof(MKMapPoint) * _pointBufferCapacity);
        MKMapPoint origin = MKMapPointForCoordinate(cooridinate);
        _pointBuffer[0] = origin;
        _pointCount = 1;
        
        double oneKilometerInMapPoints = 1000 * MKMapPointsPerMeterAtLatitude(cooridinate.latitude);
        MKMapSize oneSquareKilometer = {oneKilometerInMapPoints, oneKilometerInMapPoints};
        _boundingMapRect = ((MKMapRect){origin, oneSquareKilometer});
        
        _boundingMapRect = MKMapRectIntersection(self.boundingMapRect, MKMapRectWorld);
        
        pthread_rwlock_init(&_rwLock, NULL);
    }
    return self;
}

- (MKMapRect)addCoordinate:(CLLocationCoordinate2D)newCoordinate boundingMapRectChanged:(BOOL *)boundingMapRectChangedOut {
    pthread_rwlock_wrlock(&_rwLock);
    
    BOOL boundingMapRectChanged = NO;
    MKMapRect updateRect = MKMapRectNull;
    
    MKMapPoint newPoint = MKMapPointForCoordinate(newCoordinate);
    
    MKMapPoint prevPoint = _pointBuffer[_pointCount - 1];
    CLLocationDistance metersApart = MKMetersBetweenMapPoints(newPoint, prevPoint);
    
    if (metersApart > MINIMUM_DELTA_METERS) {
        if (_pointBufferCapacity == _pointCount) {
            _pointBufferCapacity = 2;
            _pointBuffer = realloc(_pointBuffer, sizeof(MKMapPoint) * _pointBufferCapacity);
        }
        _pointBuffer[_pointCount] = newPoint;
        _pointCount++;
        
        updateRect = [self mapRectContainingPoint:newPoint andPoint:prevPoint];
        
        MKMapRect overlayBounds = self.boundingMapRect;
        if (NO == MKMapRectContainsRect(overlayBounds, updateRect)) {
            self.boundingMapRect = [self growOverlayBounds:overlayBounds toInclude:updateRect];
            boundingMapRectChanged = YES;
        }
    }
    if (boundingMapRectChangedOut) {
        *boundingMapRectChangedOut = boundingMapRectChanged;
    }
    pthread_rwlock_unlock(&_rwLock);
    
    return updateRect;
}

- (void)readPointsWithBlockAndWait:(void (^)(MKMapPoint *pointsArray, NSUInteger pointArrayCount))block
{
    // Acquire the write lock so the list of points isn't changed while we read it
    pthread_rwlock_wrlock(&_rwLock);
    block(_pointBuffer, _pointCount);
    pthread_rwlock_unlock(&_rwLock);
}

- (void)dealloc {
    free(_pointBuffer);
    pthread_rwlock_destroy(&_rwLock);
}

#pragma mark - Private Methods
- (CLLocationCoordinate2D)coordinate
{
    __block CLLocationCoordinate2D centerCoordinate;
    [self readPointsWithBlockAndWait:^(MKMapPoint *pointsArray, NSUInteger pointsCount) {
        centerCoordinate = MKCoordinateForMapPoint(pointsArray[0]);
    }];
    return centerCoordinate;
}

- (MKMapRect)mapRectContainingPoint:(MKMapPoint)p1 andPoint:(MKMapPoint)p2 {
    MKMapSize pointSize = {0,0};
    MKMapRect newPointRect = (MKMapRect){p1,pointSize};
    MKMapRect prevPointRect = (MKMapRect){p2,pointSize};
    return MKMapRectUnion(newPointRect, prevPointRect);
}

- (MKMapRect)growOverlayBounds:(MKMapRect)overlayBounds toInclude:(MKMapRect)otherRect
{
    // The -boundingMapRect we choose was too small.
    // We grow it to be both rects, plus about
    // an extra kilometer in every direction that was too small before.
    // Usually the crumb-trail will keep growing in the direction it grew before
    // so this minimizes having to regrow, without growing off-trail.
    
    MKMapRect grownBounds = MKMapRectUnion(overlayBounds, otherRect);
    
    // Pedantically, to grow the overlay by one real kilometer, we would need to
    // grow different sides by a different number of map points, to account for
    // the number of map points per meter changing with latitude.
    // But we don't need to be exact. The center of the rect that ran over
    // is a good enough estimate for where we'll be growing the overlay.
    
    double oneKilometerInMapPoints = 1000*MKMapPointsPerMeterAtLatitude(MKCoordinateForMapPoint(otherRect.origin).latitude);
    
    // Grow by an extra kilometer in the direction of each overrun.
    if (MKMapRectGetMinY(otherRect) < MKMapRectGetMinY(overlayBounds))
    {
        grownBounds.origin.y -= oneKilometerInMapPoints;
        grownBounds.size.height += oneKilometerInMapPoints;
    }
    if (MKMapRectGetMaxY(otherRect) > MKMapRectGetMaxY(overlayBounds))
    {
        grownBounds.size.height += oneKilometerInMapPoints;
    }
    if (MKMapRectGetMinX(otherRect) < MKMapRectGetMinX(overlayBounds))
    {
        grownBounds.origin.x -= oneKilometerInMapPoints;
        grownBounds.size.width += oneKilometerInMapPoints;
    }
    if (MKMapRectGetMaxX(otherRect) > MKMapRectGetMaxX(overlayBounds))
    {
        grownBounds.size.width += oneKilometerInMapPoints;
    }
    
    // Clip to world size
    grownBounds = MKMapRectIntersection(grownBounds, MKMapRectWorld);
    
    return grownBounds;
}

@end
