//
//  HYTrackMainViewController.m
//  EasyMap
//
//  Created by hyyy on 2017/3/7.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYTrackMainViewController.h"
#import "HYTrackView.h"

@interface HYTrackMainViewController ()<MKMapViewDelegate>

@property (strong, nonatomic) HYTrackView *trackView;

@end

@implementation HYTrackMainViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"轨迹";
    [self.view addSubview:self.trackView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 设置MKMapView代理
    self.trackView.mapView.delegate = self;
    // 修改状态栏字体颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    // 隐藏导航栏
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // 取消MKMapView代理
    self.trackView.mapView.delegate = nil;
    // 取消设置状态栏字体颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    // 取消隐藏导航栏
    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark - MKMapViewDelegate
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
}

#pragma mark - setter and getter
- (HYTrackView *)trackView {
    if (!_trackView) {
        _trackView = [[HYTrackView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TAB_BAR_HEIGHT)];
    }
    return _trackView;
}

@end
