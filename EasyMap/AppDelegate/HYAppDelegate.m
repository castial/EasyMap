//
//  HYAppDelegate.m
//  EasyMap
//
//  Created by hyyy on 2017/2/23.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYAppDelegate.h"
#import "HYTabBarController.h"

@implementation HYAppDelegate

#pragma mark - UIApplicationDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    self.window.rootViewController = [[HYTabBarController alloc] init];
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
