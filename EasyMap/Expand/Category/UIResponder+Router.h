//
//  UIResponder+Router.h
//  EasyMap
//
//  Created by hyyy on 2017/3/13.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, HYControlEvent) {
    HYControlEventEdingingChanged,  // 编辑内容改变
    HYControlEventTouchUpInside,    // 视图点击事件
};

@interface UIResponder (Router)


/**
 发送事件路由消息

 @param eventName 事件名
 @param userInfo 携带数据
 */
- (void)hy_routerEventWithName:(HYControlEvent)eventName userInfo:(NSObject *)userInfo;

@end
