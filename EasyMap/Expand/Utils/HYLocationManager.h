//
//  HYLocationManager.h
//  EasyMap
//
//  Created by hyyy on 2017/3/7.
//  Copyright © 2017年 hyyy. All rights reserved.
//

/*
 定位管理类主要实现的目标是：

 1. 隔一段时间，上报用户位置；
 2. 用户移动速度很慢，那么隔一段距离上传用户位置；
 3. 用户长时间位置不变，那么不用上报；
 4. 切换到后台也要能上报位置；
 5. app被杀死也能上报位置。
 */

#import <CoreLocation/CoreLocation.h>

@interface HYLocationManager : CLLocationManager

+ (instancetype)sharedInstance;

@end
