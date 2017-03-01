//
//  HYLocateChooseController.h
//  EasyMap
//
//  Created by hyyy on 2017/3/1.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYLocateChooseController : UIViewController

// 当前位置描述
@property (nonatomic, strong) NSString *addressDescription;
// 地址周边POI信息，成员类型为BMKPoiInfo
@property (nonatomic, strong) NSArray<BMKPoiInfo *> *poiList;

@end
