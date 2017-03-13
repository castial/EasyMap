//
//  HYLocateView.h
//  EasyMap
//
//  Created by hyyy on 2017/3/8.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import <UIKit/UIKit.h>

// 定位页面点击事件类型
typedef NS_ENUM(NSUInteger, HYLocateEventType) {
    HYLocateEventLocate,    // 点击定位事件
    HYLocateEventContact,       // 点击紧急联系人事件
};

@interface HYLocateView : UIView

// 开始定位按钮动画
- (void)startLocateAnimation;

// 结束定位按钮动画
- (void)endLocateAnimation;

@end
