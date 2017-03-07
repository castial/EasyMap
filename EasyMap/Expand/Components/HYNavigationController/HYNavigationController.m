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
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: navTitleColor, NSFontAttributeName:navTitleFont}];
    [[UINavigationBar appearance] setTintColor:navTitleColor];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:58.0/255.0 green:155.0/255.0 blue:252.0/255.0 alpha:1.0f]];
    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"btn_back@3x.png"]];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"btn_back@3x.png"]];
    
    // 修改UIBarButtonItem相关属性
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : navTitleColor, NSFontAttributeName : [UIFont systemFontOfSize:16]} forState:UIControlStateNormal];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
}

@end
