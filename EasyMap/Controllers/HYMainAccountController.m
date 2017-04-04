//
//  HYMainAccountController.m
//  EasyMap
//
//  Created by hyyy on 2017/3/7.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYMainAccountController.h"
#import "HYMainAccountView.h"

@interface HYMainAccountController ()

@property (nonatomic, strong) HYMainAccountView *accountView;

@end

@implementation HYMainAccountController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我";
    [self.view addSubview:self.accountView];
}

#pragma mark - setter and getter
- (HYMainAccountView *)accountView {
    if (!_accountView) {
        _accountView = [[HYMainAccountView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - STATUS_BAR_HEIGHT - NAVIGATION_BAR_HEIGHT - TAB_BAR_HEIGHT)];
    }
    return _accountView;
}

@end
