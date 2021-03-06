//
//  HYNavigationController.m
//  EasyMap
//
//  Created by hyyy on 2017/3/6.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYNavigationController.h"

@interface HYNavigationController ()

@end

@implementation HYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 修改导航栏相关属性
    UIColor *navTitleColor = [UIColor whiteColor];    // 导航栏字体颜色
    UIFont *navTitleFont = [UIFont boldSystemFontOfSize:18];    // 导航栏字体大小

    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: navTitleColor, NSFontAttributeName:navTitleFont}];
    [[UINavigationBar appearance] setTintColor:navTitleColor];
    [[UINavigationBar appearance] setBarTintColor:HY_Tint_Color];
    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"btn_back@3x.png"]];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"btn_back@3x.png"]];
    
    // 取消导航栏底部横线
//    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    // 修改UIBarButtonItem相关属性
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : navTitleColor, NSFontAttributeName : [UIFont systemFontOfSize:16]} forState:UIControlStateNormal];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
