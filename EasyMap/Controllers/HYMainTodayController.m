//
//  HYMainTodayController.m
//  EasyMap
//
//  Created by hyyy on 2017/3/27.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYMainTodayController.h"
#import "HYMainTodayView.h"

@interface HYMainTodayController ()

@property (nonatomic, strong) HYMainTodayView *todayView;

@end

@implementation HYMainTodayController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"今天";
    
    [self.view addSubview:self.todayView];
}

#pragma mark - setter and getter
- (HYMainTodayView *)todayView {
    if (!_todayView) {
        _todayView = [[HYMainTodayView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _todayView;
}

@end
