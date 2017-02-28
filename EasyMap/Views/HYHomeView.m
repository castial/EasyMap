//
//  HYHomeView.m
//  EasyMap
//
//  Created by hyyy on 2017/2/27.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYHomeView.h"
#import "HYNavSearchBar.h"

@interface HYHomeView()

@property (strong, nonatomic) UIView *operateView;

@property (strong, nonatomic) UIButton *sendLocationBtn;

@end

@implementation HYHomeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        [self initLayout];
    }
    return self;
}

- (void)initUI {
    [self addSubview:self.mapView];
    [self addSubview:self.operateView];
    [self.operateView addSubview:self.sendLocationBtn];
}

- (void)initLayout {
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self);
    }];
    [self.operateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(@100);
    }];
    [self.sendLocationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.operateView.mas_centerX);
        make.centerY.equalTo(self.operateView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
}

#pragma mark - Events
- (void)clickedBtnHandler:(id)sender {
    UIButton *btn = (UIButton *)sender;
    HYOperateButton type = btn.tag;
    if ([self.delegate respondsToSelector:@selector(clickedHomeOperateBtnHandler:)]) {
        [self.delegate clickedHomeOperateBtnHandler:type];
    }
}

#pragma mark - setter and getter
- (BMKMapView *)mapView {
    if (!_mapView) {
        _mapView = [[BMKMapView alloc] init];
        _mapView.showsUserLocation = YES;
        _mapView.userTrackingMode = BMKUserTrackingModeHeading;
        _mapView.zoomLevel = 15;
        
        //设置定位图层自定义样式
        BMKLocationViewDisplayParam *userlocationStyle = [[BMKLocationViewDisplayParam alloc] init];
        userlocationStyle.isAccuracyCircleShow = NO; //精度圈是否显示
        userlocationStyle.isRotateAngleValid = YES;   //跟随态旋转角度是否生效
        //更新参样式信息
        [_mapView updateLocationViewWithParam:userlocationStyle];
    }
    return _mapView;
}

- (UIView *)operateView {
    if (!_operateView) {
        _operateView = [[UIView alloc] init];
        _operateView.backgroundColor = [UIColor whiteColor];
    }
    return _operateView;
}

- (UIButton *)sendLocationBtn {
    if (!_sendLocationBtn) {
        _sendLocationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendLocationBtn.backgroundColor = [UIColor greenColor];
        _sendLocationBtn.tag = HYOperateButtonSend;
        [_sendLocationBtn addTarget:self action:@selector(clickedBtnHandler:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendLocationBtn;
}

@end

