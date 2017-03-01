//
//  UIViewController+Present.m
//  EasyMap
//
//  Created by hyyy on 2017/3/1.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "UIViewController+Present.h"

@implementation UIViewController (Present)

- (void)hy_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewControllerToPresent];
    [self presentViewController:nav animated:YES completion:completion];
}

@end
