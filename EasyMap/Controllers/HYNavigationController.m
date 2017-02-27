//
//  HYNavigationController.m
//  EasyMap
//
//  Created by hyyy on 2017/2/27.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYNavigationController.h"
#import "HYHomeViewController.h"

@interface HYNavigationController ()

@property (strong, nonatomic) HYHomeViewController *homeVC;

@end

@implementation HYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController:self.homeVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setter and getter
- (HYHomeViewController *)homeVC {
    if (!_homeVC) {
        _homeVC = [[HYHomeViewController alloc] init];
    }
    return _homeVC;
}

@end
