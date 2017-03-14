//
//  UIResponder+Router.m
//  EasyMap
//
//  Created by hyyy on 2017/3/13.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "UIResponder+Router.h"

@implementation UIResponder (Router)

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSObject *)userInfo
{
    [[self nextResponder] routerEventWithName:eventName userInfo:userInfo];
}

@end
