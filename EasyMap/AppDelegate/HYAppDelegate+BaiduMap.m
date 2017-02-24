//
//  HYAppDelegate+BaiduMap.m
//  EasyMap
//
//  Created by hyyy on 2017/2/24.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYAppDelegate+BaiduMap.h"

@implementation HYAppDelegate (BaiduMap)

- (void)startBaiduMapManager {
    BMKMapManager *mapManager = [[BMKMapManager alloc] init];
    BOOL ret = [mapManager start:BAIDU_MAP_KEY generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed");
    }
}

@end
