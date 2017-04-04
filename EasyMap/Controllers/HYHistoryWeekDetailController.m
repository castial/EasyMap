//
//  HYHistoryWeekDetailController.m
//  EasyMap
//
//  Created by 李洋 on 2017/4/4.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYHistoryWeekDetailController.h"
#import "HYHistoryWeekDetailView.h"

@interface HYHistoryWeekDetailController ()

@property (nonatomic, strong) HYHistoryWeekDetailView *detailView;

@end

@implementation HYHistoryWeekDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"步数";
    [self.view addSubview:self.detailView];
}

#pragma mark - setter and getter
- (HYHistoryWeekDetailView *)detailView {
    if (!_detailView) {
        _detailView = [[HYHistoryWeekDetailView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - STATUS_BAR_HEIGHT - NAVIGATION_BAR_HEIGHT - TAB_BAR_HEIGHT)];
    }
    return _detailView;
}

@end
