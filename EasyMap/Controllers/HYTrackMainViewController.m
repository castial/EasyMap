//
//  HYTrackMainViewController.m
//  EasyMap
//
//  Created by hyyy on 2017/3/7.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYTrackMainViewController.h"
#import "HYTrackView.h"
#import "HYLocationConverter.h"

@interface HYTrackMainViewController ()<MKMapViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) HYTrackView *trackView;

@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation HYTrackMainViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"轨迹";
    [self.view addSubview:self.trackView];
    
    [self.locationManager startUpdatingLocation];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 修改状态栏字体颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    // 隐藏导航栏
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // 取消设置状态栏字体颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    // 取消隐藏导航栏
    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations {
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = [HYLocationConverter wgs84ToGcj02:location.coordinate];

    MKCoordinateRegion newRegion = MKCoordinateRegionMakeWithDistance(coordinate, 2000, 2000);
    
    [self.trackView.mapView setRegion:newRegion animated:YES];
    [self.locationManager stopUpdatingLocation];
}

#pragma mark - Events
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSObject *)userInfo {
    if ([eventName isEqualToString:HYTrackEventLocate]) {
        // 定位事件
        [self.locationManager startUpdatingLocation];
    }else if ([eventName isEqualToString:HYTrackEventLocate]) {
        // 追踪按钮
    }else {
        [super routerEventWithName:eventName userInfo:userInfo];
    }
}

#pragma mark - setter and getter
- (HYTrackView *)trackView {
    if (!_trackView) {
        _trackView = [[HYTrackView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TAB_BAR_HEIGHT)];
    }
    return _trackView;
}

- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    return _locationManager;
}

@end
