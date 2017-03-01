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

// 底部工具栏
@property (strong, nonatomic) UIToolbar *toolBar;
@property (strong, nonatomic) UIBarButtonItem *locateItem;  // 定位按钮
@property (strong, nonatomic) UIBarButtonItem *navigateItem;    // 导航按钮
@property (strong, nonatomic) UIBarButtonItem *meItem;  // 我的按钮

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
    [self addSubview:self.toolBar];
}

- (void)initLayout {
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self);
    }];
    [self.toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(@44);
    }];
}

#pragma mark - Events
- (void)clickedBtnHandler:(id)sender {
    UIButton *btn = (UIButton *)sender;
    HYOperateItem type = btn.tag;
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

- (UIToolbar *)toolBar {
    if (!_toolBar) {
        _toolBar = [[UIToolbar alloc] init];
        _toolBar.backgroundColor = [UIColor lightGrayColor];
        // 添加item
        UIBarButtonItem *flexibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [_toolBar setItems:@[self.locateItem, flexibleItem, self.navigateItem, flexibleItem, self.meItem] animated:YES];
    }
    return _toolBar;
}

- (UIBarButtonItem *)locateItem {
    if (!_locateItem) {
        _locateItem = [[UIBarButtonItem alloc] initWithTitle:@"第一" style:UIBarButtonItemStylePlain target:self action:@selector(clickedBtnHandler:)];
        _locateItem.tag = HYOperateItemLocate;
    }
    return _locateItem;
}

- (UIBarButtonItem *)navigateItem {
    if (!_navigateItem) {
        _navigateItem = [[UIBarButtonItem alloc] initWithTitle:@"第二" style:UIBarButtonItemStylePlain target:self action:@selector(clickedBtnHandler:)];
        _navigateItem.tag = HYOperateItemNavigate;
    }
    return _navigateItem;
}

- (UIBarButtonItem *)meItem {
    if (!_meItem) {
        _meItem = [[UIBarButtonItem alloc] initWithTitle:@"第三" style:UIBarButtonItemStylePlain target:self action:@selector(clickedBtnHandler:)];
        _meItem.tag = HYOperateItemMe;
    }
    return _meItem;
}

@end

