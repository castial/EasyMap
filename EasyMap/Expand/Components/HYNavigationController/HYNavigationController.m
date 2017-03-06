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
    UIColor *navTitleColor = [UIColor colorWithRed:0.322 green:0.322 blue:0.322 alpha:1.0f];    // 导航栏字体颜色
    UIFont *navTitleFont = [UIFont boldSystemFontOfSize:16];    // 导航栏字体大小
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: navTitleColor, NSFontAttributeName:navTitleFont}];
    [[UINavigationBar appearance] setTintColor:navTitleColor];
    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"btn_back@3x.png"]];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"btn_back@3x.png"]];
    
    // 修改UIBarButtonItem相关属性
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : navTitleColor, NSFontAttributeName : [UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
}

@end
