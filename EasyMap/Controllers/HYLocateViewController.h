//
//  HYLocateViewController.h
//  EasyMap
//
//  Created by hyyy on 2017/3/1.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYLocateViewController : UIViewController

// 当前位置
@property (nonatomic, strong) BMKReverseGeoCodeResult *currentLocation;
// 地址周边POI信息，成员类型为BMKPoiInfo
@property (nonatomic, strong) NSArray<BMKPoiInfo *> *poiList;

@end
