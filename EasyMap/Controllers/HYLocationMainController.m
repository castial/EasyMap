//
//  HYLocationMainController.m
//  EasyMap
//
//  Created by hyyy on 2017/3/7.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYLocationMainController.h"
#import "HYLocateView.h"

typedef void(^HYGeocodeCompletionHandler)(NSString *placeInfo);

@interface HYLocationMainController ()<HYLocateViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) HYLocateView *locateView;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation HYLocationMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"定位";
    
    [self.view addSubview:self.locateView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 取消导航栏横线
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // 加上导航栏横线
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

#pragma mark - HYLocateViewDelegate
- (void)didSelectLocateBtn {
    // 开始定位
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
    }
    [self.locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    NSLog(@"经度：%f, 纬度: %f", coordinate.longitude, coordinate.latitude);
    [self geocodeLocationWithLocation:location completionHandler:^(NSString *placeInfo) {
        NSLog(@"当前位置: %@", placeInfo);
    }];
    
    // 停止定位
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"定位出错");
}

#pragma mark - Private Methods
// 根据经纬度获取当前位置详细信息
- (void)geocodeLocationWithLocation:(CLLocation *)location completionHandler:(HYGeocodeCompletionHandler)completionHandler {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placeMark = [placemarks lastObject];
        NSDictionary *dic = placeMark.addressDictionary;
        
        NSString *placeInfo = [NSString stringWithFormat:@"%@%@", [[dic objectForKey:@"FormattedAddressLines"] firstObject], placeMark.name];
        completionHandler(placeInfo);
    }];
}

#pragma mark - setter and getter
- (HYLocateView *)locateView {
    if (!_locateView) {
        _locateView = [[HYLocateView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        _locateView.delegate = self;
    }
    return _locateView;
}

- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.distanceFilter = 10;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    return _locationManager;
}

@end
