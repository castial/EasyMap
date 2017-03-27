//
//  HYTabBarController.m
//  EasyMap
//
//  Created by hyyy on 2017/3/7.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYTabBarController.h"
#import "HYNavigationController.h"
#import "HYMainAccountController.h"
#import "HYMainTodayController.h"
#import "HYMainHistoryController.h"

@interface HYTabBarController ()

@end

@implementation HYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 今天
    HYMainTodayController *todayVC = [[HYMainTodayController alloc] init];
    [self setupChildVC:todayVC title:@"今天" imageName:@"locate" selectedImageName:@"locate_selected"];
    // 历史
    HYMainHistoryController *historyVC = [[HYMainHistoryController alloc] init];
    [self setupChildVC:historyVC title:@"数据" imageName:@"track" selectedImageName:@"track_selected"];
    // 我
    HYMainAccountController *accountVC = [[HYMainAccountController alloc] init];
    [self setupChildVC:accountVC title:@"我" imageName:@"account" selectedImageName:@"account_selected"];
    
    // 修改TabBar效果
    [[UITabBar appearance] setTintColor:HY_Tint_Color];
    [[UITabBar appearance] setTranslucent:NO];
    // 取消UITabBar横线
//    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
//    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
}

#pragma mark - Private Methods
- (void)setupChildVC:(UIViewController *)childVC title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    HYNavigationController *navVC = [[HYNavigationController alloc] initWithRootViewController:childVC];
    navVC.tabBarItem.title = title;
    navVC.tabBarItem.image = [UIImage imageNamed:imageName];
    navVC.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    [self addChildViewController:navVC];
}

@end
