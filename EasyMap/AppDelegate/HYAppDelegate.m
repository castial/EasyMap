//
//  HYAppDelegate.m
//  EasyMap
//
//  Created by hyyy on 2017/2/23.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYAppDelegate.h"
#import "HYAppDelegate+BaiduMap.h"
#import "HYHomeViewController.h"

@implementation HYAppDelegate

#pragma mark - UIApplicationDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    HYHomeViewController *homeVC = [[HYHomeViewController alloc] init];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:homeVC];
    
    // 开启百度地图
    [self startBaiduMapManager];
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
