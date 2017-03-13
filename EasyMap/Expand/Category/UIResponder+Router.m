//
//  UIResponder+Router.m
//  EasyMap
//
//  Created by hyyy on 2017/3/13.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "UIResponder+Router.h"

@implementation UIResponder (Router)

- (void)hy_routerEventWithName:(HYControlEvent)eventName userInfo:(NSObject *)userInfo {
    [[self nextResponder] hy_routerEventWithName:eventName userInfo:userInfo];
}

@end
