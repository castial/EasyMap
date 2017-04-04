//
//  HYMainHistoryController.m
//  EasyMap
//
//  Created by hyyy on 2017/3/27.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYMainHistoryController.h"
#import "HYMainHistoryView.h"

@interface HYMainHistoryController ()

@property (nonatomic, strong) HYMainHistoryView *historyView;

@end

@implementation HYMainHistoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"一周";
    [self.view addSubview:self.historyView];
}

#pragma mark - setter and getter
- (HYMainHistoryView *)historyView {
    if (!_historyView) {
        _historyView = [[HYMainHistoryView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - STATUS_BAR_HEIGHT - NAVIGATION_BAR_HEIGHT - TAB_BAR_HEIGHT)];
    }
    return _historyView;
}

@end
