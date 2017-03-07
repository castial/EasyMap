//
//  HYLocationManager.m
//  EasyMap
//
//  Created by hyyy on 2017/3/7.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYLocationManager.h"

@interface HYLocationManager()<CLLocationManagerDelegate>

@end

@implementation HYLocationManager

+ (instancetype)sharedInstance {
    static HYLocationManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HYLocationManager alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.delegate = self;
        self.distanceFilter = 100;
        self.desiredAccuracy = kCLLocationAccuracyBest;
    }
    return self;
}

#pragma mark - CLLocationManagerDelegate
// 当获取到一个新位置时调用
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
}

@end
