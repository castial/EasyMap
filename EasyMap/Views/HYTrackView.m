//
//  HYTrackView.m
//  EasyMap
//
//  Created by hyyy on 2017/3/14.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYTrackView.h"

@interface HYTrackView()

@property (strong, nonatomic) UIButton *locateBtn;
@property (strong, nonatomic) UIButton *trackBtn;

@end

@implementation HYTrackView

#pragma mark - lifecycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        [self initLayout];
    }
    return self;
}

#pragma mark - init UI and Layout
- (void)initUI {
    [self addSubview:self.mapView];
    [self addSubview:self.locateBtn];
    [self addSubview:self.trackBtn];
}

- (void)initLayout {
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self);
    }];
    [self.locateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [self.trackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.size.mas_equalTo(CGSizeMake(100, 60));
    }];
}

#pragma mark - setter and getter
- (MKMapView *)mapView {
    if (!_mapView) {
        _mapView = [[MKMapView alloc] init];
        _mapView.showsUserLocation = YES;   // 显示用户位置
        _mapView.showsBuildings = YES;      // 显示建筑
        _mapView.showsCompass = YES;        // 显示指南针
        _mapView.userTrackingMode = MKUserTrackingModeFollow;   // 跟踪用户的移动
    }
    return _mapView;
}

- (UIButton *)locateBtn {
    if (!_locateBtn) {
        _locateBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        _locateBtn.backgroundColor = [UIColor whiteColor];
        _locateBtn.layer.cornerRadius = CGRectGetHeight(_locateBtn.frame) / 2;
        _locateBtn.layer.masksToBounds = YES;
    }
    return _locateBtn;
}

- (UIButton *)trackBtn {
    if (!_trackBtn) {
        _trackBtn = [[UIButton alloc] init];
        _trackBtn.backgroundColor = [UIColor whiteColor];
        _trackBtn.layer.cornerRadius = 5;
        _trackBtn.layer.masksToBounds = YES;
    }
    return _trackBtn;
}

@end
