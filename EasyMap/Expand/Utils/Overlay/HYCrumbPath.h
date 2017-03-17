//
//  HYCrumbPath.h
//  EasyMap
//
//  Created by hyyy on 2017/3/16.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface HYCrumbPath : NSObject

- (id)initWithCenterCoordinate:(CLLocationCoordinate2D)cooridinate;

- (MKMapRect)addCoordinate:(CLLocationCoordinate2D)newCoordinate boundingMapRectChanged:(BOOL *)boundingMapRectChangedOut;

- (void)readPointsWithBlockAndWait:(void (^)(MKMapPoint *pointsArray, NSUInteger pointArrayCount))block;

@end
