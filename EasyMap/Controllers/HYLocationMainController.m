//
//  HYLocationMainController.m
//  EasyMap
//
//  Created by hyyy on 2017/3/7.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYLocationMainController.h"
#import "HYLocateView.h"
#import <MessageUI/MessageUI.h>

typedef void(^HYGeocodeCompletionHandler)(NSString *placeInfo);

@interface HYLocationMainController ()<HYLocateViewDelegate, CLLocationManagerDelegate, MFMessageComposeViewControllerDelegate>

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
    [[HYProgressHelper sharedInstance] showLoading:@"开始定位"];
    [self.locateView startLocateAnimation];
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    NSLog(@"经度：%f, 纬度: %f", coordinate.longitude, coordinate.latitude);
    [self geocodeLocationWithLocation:location completionHandler:^(NSString *placeInfo) {
        NSLog(@"当前位置: %@", placeInfo);
        [[HYProgressHelper sharedInstance] hideLoading];
        [self.locateView endLocateAnimation];
        [self showMessageController:placeInfo];
    }];
    
    // 停止定位
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"定位出错");
    [self.locateView endLocateAnimation];
    [[HYProgressHelper sharedInstance] showToast:error.description];
}

#pragma mark - MFMessageComposeViewControllerDelegate
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [controller dismissViewControllerAnimated:YES completion:nil];
    if (result == MessageComposeResultSent) {
        // 发送成功
        [[HYProgressHelper sharedInstance] showToast:@"短信发送成功"];
    }else if (result == MessageComposeResultCancelled) {
        // 取消发送
//        [[HYProgressHelper sharedInstance] showToast:@"短信取消发送"];
    }else {
        // 发送失败
        [[HYProgressHelper sharedInstance] showToast:@"短信取消发送"];
    }
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

// 跳转到发送短信界面
- (void)showMessageController:(NSString *)message {
    if ([MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController *messageVC = [[MFMessageComposeViewController alloc] init];
        // 如果本地有紧急联系人的话，填写联系人手机号
        messageVC.recipients = @[@"17607557133"];
        messageVC.body = message;
        messageVC.messageComposeDelegate = self;
        [self presentViewController:messageVC animated:YES completion:nil];
        [[[[messageVC viewControllers] lastObject] navigationItem] setTitle:@"定位信息"];   // 修改短信界面
    }else {
        [[HYProgressHelper sharedInstance] showToast:@"该设备不支持短信功能"];
    }
}

#pragma mark - setter and getter
- (HYLocateView *)locateView {
    if (!_locateView) {
        _locateView = [[HYLocateView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
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