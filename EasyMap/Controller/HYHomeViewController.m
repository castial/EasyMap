//
//  HYHomeViewController.m
//  EasyMap
//
//  Created by hyyy on 2017/2/23.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYHomeViewController.h"
#import <BaiduMapAPI_Map/BMKMapView.h>

@interface HYHomeViewController ()<BMKMapViewDelegate, BMKLocationServiceDelegate>

@property (strong, nonatomic) BMKMapView *mapView;
@property (strong, nonatomic) BMKLocationService *locationService;  // 定位服务
@property (strong, nonatomic) BMKPointAnnotation *annotation;   // 标注

@end

@implementation HYHomeViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.mapView];
    
    // 启动定位服务
    [self.locationService startUserLocationService];
    // 添加标注
    [self.mapView addAnnotation:self.annotation];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.mapView.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    // 不用的时候置为nil，否则影响内存的释放
    self.mapView.delegate = nil;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

#pragma mark - BMKMapViewDelegate
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation {
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotation"];
        annotationView.pinColor = BMKPinAnnotationColorRed;
        annotationView.animatesDrop = YES;
        annotationView.draggable = YES;
        return annotationView;
    }
    return nil;
}

#pragma mark - BMKLocationServiceDelegate
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation {
    NSLog(@"heading is %@", userLocation.heading);
    
    // 更新定位信息
    [self.mapView updateLocationData:userLocation];
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    float zoomLevel = 0.02;
    BMKCoordinateRegion region = BMKCoordinateRegionMake(userLocation.location.coordinate, BMKCoordinateSpanMake(zoomLevel, zoomLevel));
    
    // 更新定位信息
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    CLLocationCoordinate2D coor;
    coor.latitude = userLocation.location.coordinate.latitude;
    coor.longitude = userLocation.location.coordinate.longitude;
    self.annotation.coordinate = coor;
}

#pragma mark - Events
#pragma mark - Public Methods
#pragma mark - Private Methods
#pragma mark - setter and getter
- (BMKMapView *)mapView {
    if (!_mapView) {
        _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _mapView.showsUserLocation = YES;
    }
    return _mapView;
}

- (BMKLocationService *)locationService {
    if (!_locationService) {
        _locationService = [[BMKLocationService alloc] init];
        _locationService.delegate = self;
    }
    return _locationService;
}

- (BMKPointAnnotation *)annotation {
    if (!_annotation) {
        _annotation = [[BMKPointAnnotation alloc] init];
        _annotation.title = @"我的位置";
        _annotation.subtitle = @"我的位置介绍";
    }
    return _annotation;
}

@end
