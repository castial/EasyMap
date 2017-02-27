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

@property (strong, nonatomic) HYNavSearchBar *searchView;

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
    [self.operateView addSubview:self.searchView];
}

- (void)initLayout {
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self);
    }];
    [self.operateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(@100);
    }];
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.operateView.mas_left).offset(10);
        make.top.equalTo(self.operateView.mas_top).offset(5);
        make.right.equalTo(self.operateView.mas_right).offset(-10);
    }];
}

#pragma mark - setter and getter
- (BMKMapView *)mapView {
    if (!_mapView) {
        _mapView = [[BMKMapView alloc] init];
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

- (HYNavSearchBar *)searchView {
    if (!_searchView) {
        _searchView = [[HYNavSearchBar alloc] init];
        _searchView.searchPlaceHolder = @"ssousuo";
    }
    return _searchView;
}

@end

