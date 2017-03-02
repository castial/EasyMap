//
//  UIViewController+HUB.m
//  EasyMap
//
//  Created by hyyy on 2017/3/2.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "UIViewController+HUB.h"
#import <objc/runtime.h>

@implementation UIViewController (HUB)

static char const *HY_HUB_KEY = "hy_hub_key";

- (void)setHy_hub:(MBProgressHUD *)hy_hub {
    objc_setAssociatedObject(self, HY_HUB_KEY, hy_hub, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MBProgressHUD *)hy_hub {
    return objc_getAssociatedObject(self, HY_HUB_KEY);
}

@end
