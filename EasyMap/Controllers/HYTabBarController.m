//
//  HYTabBarController.m
//  EasyMap
//
//  Created by hyyy on 2017/3/7.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYTabBarController.h"
#import "HYNavigationController.h"
#import "HYLocationMainController.h"
#import "HYTrackMainViewController.h"
#import "HYAccountMainController.h"

@interface HYTabBarController ()

@end

@implementation HYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 定位
    HYLocationMainController *locateVC = [[HYLocationMainController alloc] init];
    [self setupChildVC:locateVC title:@"定位" imageName:nil selectedImageName:nil];
    // 轨迹
    HYTrackMainViewController *trackVC = [[HYTrackMainViewController alloc] init];
    [self setupChildVC:trackVC title:@"轨迹" imageName:nil selectedImageName:nil];
    // 我
    HYAccountMainController *accountVC = [[HYAccountMainController alloc] init];
    [self setupChildVC:accountVC title:@"我" imageName:nil selectedImageName:nil];
    
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
