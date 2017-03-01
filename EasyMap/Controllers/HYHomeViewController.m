//
//  HYHomeViewController.m
//  EasyMap
//
//  Created by hyyy on 2017/2/23.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYHomeViewController.h"
#import "HYHomeView.h"
#import "HYNavSearchBar.h"
#import "HYLocateChooseController.h"
#import "UIViewController+Present.h"

@interface HYHomeViewController ()<BMKMapViewDelegate, BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate, HYNavSearchBarDelegate, HYHomeOperateDelegate>

@property (strong, nonatomic) HYHomeView *homeView;
@property (strong, nonatomic) HYNavSearchBar *searchView;   // 导航栏搜索

@property (strong, nonatomic) BMKLocationService *locationService;  // 定位服务
@property (strong, nonatomic) BMKGeoCodeSearch *geoSearch;  // geo搜索服务

@end

@implementation HYHomeViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = self.searchView;
    [self.view addSubview:self.homeView];
    
    // 启动定位服务
    [self.locationService startUserLocationService];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.homeView.mapView.delegate = self;
    self.locationService.delegate = self;
    self.geoSearch.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    // 不用的时候置为nil，否则影响内存的释放
    self.homeView.mapView.delegate = nil;
    self.locationService.delegate = nil;
    self.geoSearch.delegate = nil;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

#pragma mark - BMKMapViewDelegate

#pragma mark - BMKLocationServiceDelegate
/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation {
    [self.homeView.mapView updateLocationData:userLocation];
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    self.homeView.mapView.centerCoordinate = userLocation.location.coordinate;
    
    [self.homeView.mapView updateLocationData:userLocation];
}

#pragma mark - BMKGeoCodeSearchDelegate
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    if (error == 0) {
        BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
        annotation.coordinate = result.location;
        annotation.title = result.address;
        NSString *address = [NSString stringWithFormat:@"%@(%@)", result.address, result.sematicDescription];
        
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:address preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:nil];
//        [alertController addAction:cancelAction];
//        [self presentViewController:alertController animated:YES completion:nil];
        
        // 测试
        HYLocateChooseController *locateChoostVC = [[HYLocateChooseController alloc] init];
        locateChoostVC.addressDescription = address;
        locateChoostVC.poiList = result.poiList;
        [self hy_presentViewController:locateChoostVC animated:YES completion:nil];
    }
}

#pragma mark - HYNavSearchBarDelegate
- (void)clickedSearchBarHandler {
    NSLog(@"您点击了搜索框");
}

#pragma mark - HYHomeOperateDelegate
- (void)clickedHomeOperateBtnHandler:(HYOperateItem)itemType {
    NSLog(@"按钮功能类型；%ld", itemType);
    switch (itemType) {
        case HYOperateItemLocate:{
            
            NSLog(@"定位的经度：%f, 纬度：%f", self.locationService.userLocation.location.coordinate.longitude, self.locationService.userLocation.location.coordinate.latitude);
            
            // 反编码经纬度，获取详细地址
            [self reverseGeoSearchWithLongitude:self.locationService.userLocation.location.coordinate.longitude latitude:self.locationService.userLocation.location.coordinate.latitude];
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - Events
#pragma mark - Public Methods
#pragma mark - Private Methods
/**
 根据经纬度反geo检索出位置地址

 @param longitude 经度
 @param latitude 纬度
 */
- (void)reverseGeoSearchWithLongitude:(float)longitude latitude:(float)latitude {
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
    if (longitude != 0 && latitude != 0) {
        pt = (CLLocationCoordinate2D){latitude, self.locationService.userLocation.location.coordinate.longitude};
    }
    BMKReverseGeoCodeOption *reverseOption = [[BMKReverseGeoCodeOption alloc] init];
    reverseOption.reverseGeoPoint = pt;
    BOOL flag = [self.geoSearch reverseGeoCode:reverseOption];
    if (flag) {
        NSLog(@"geo检索成功");
    }else {
        NSLog(@"geo检索失败");
    }
}

#pragma mark - setter and getter
- (HYHomeView *)homeView {
    if (!_homeView) {
        _homeView = [[HYHomeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _homeView.delegate = self;
    }
    return _homeView;
}

- (HYNavSearchBar *)searchView {
    if (!_searchView) {
        _searchView = [[HYNavSearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        _searchView.searchPlaceHolder = @"搜索地点、饭店、公园或者酒店";
        _searchView.delegate = self;
    }
    return _searchView;
}

- (BMKLocationService *)locationService {
    if (!_locationService) {
        _locationService = [[BMKLocationService alloc] init];
    }
    return _locationService;
}

- (BMKGeoCodeSearch *)geoSearch {
    if (!_geoSearch) {
        _geoSearch = [[BMKGeoCodeSearch alloc] init];
    }
    return _geoSearch;
}

@end
