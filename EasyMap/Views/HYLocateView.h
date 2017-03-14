//
//  HYLocateView.h
//  EasyMap
//
//  Created by hyyy on 2017/3/8.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HYLocateEventLocate @"HYLocateEventLocate"  // 点击定位事件
#define HYLocateEventContact @"HYLocateEventContact"    // 点击紧急联系人事件

@interface HYLocateView : UIView

// 开始定位按钮动画
- (void)startLocateAnimation;

// 结束定位按钮动画
- (void)endLocateAnimation;

@end
