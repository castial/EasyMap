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

@interface HYHomeViewController ()<BMKMapViewDelegate, BMKLocationServiceDelegate, HYNavSearchBarDelegate>

@property (strong, nonatomic) HYHomeView *homeView;
@property (strong, nonatomic) HYNavSearchBar *searchView;   // 导航栏搜索

@property (strong, nonatomic) BMKLocationService *locationService;  // 定位服务

@end

@implementation HYHomeViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.title = @"首页";
    self.navigationItem.titleView = self.searchView;
    [self.view addSubview:self.homeView];
    
    // 启动定位服务
    [self.locationService startUserLocationService];
    NSLog(@"背景颜色: %@", self.view.backgroundColor);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    self.mapView.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    // 不用的时候置为nil，否则影响内存的释放
//    self.mapView.delegate = nil;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

#pragma mark - BMKMapViewDelegate

#pragma mark - BMKLocationServiceDelegate
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation {
    NSLog(@"heading is %@", userLocation.heading);
    
    // 更新定位信息
//    [self.mapView updateLocationData:userLocation];
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    float zoomLevel = 0.02;
    BMKCoordinateRegion region = BMKCoordinateRegionMake(userLocation.location.coordinate, BMKCoordinateSpanMake(zoomLevel, zoomLevel));
    
    // 更新定位信息
//    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    CLLocationCoordinate2D coor;
    coor.latitude = userLocation.location.coordinate.latitude;
    coor.longitude = userLocation.location.coordinate.longitude;
//    self.annotation.coordinate = coor;
}

#pragma mark - HYNavSearchBarDelegate
- (void)clickedSearchBarHandler {
    NSLog(@"您点击了搜索框");
}

#pragma mark - Events
#pragma mark - Public Methods
#pragma mark - Private Methods
#pragma mark - setter and getter
- (HYHomeView *)homeView {
    if (!_homeView) {
        _homeView = [[HYHomeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
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
        _locationService.delegate = self;
    }
    return _locationService;
}

@end
