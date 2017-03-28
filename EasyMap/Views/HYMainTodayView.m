//
//  HYMainTodayView.m
//  EasyMap
//
//  Created by hyyy on 2017/3/27.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYMainTodayView.h"
#import "HYMainTodayCircleView.h"
#import "HYMainTodayBottomView.h"

@interface HYMainTodayView()

@property (nonatomic, strong) HYMainTodayCircleView *circieView;
@property (nonatomic, strong) HYMainTodayBottomView *bottomView;

@end

@implementation HYMainTodayView

#pragma mark - lifecycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

#pragma mark - init UI and Layout
- (void)initUI {
    [self addSubview:self.circieView];
    [self addSubview:self.bottomView];
}

- (void)layoutSubviews {
    [self.circieView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(CGRectGetWidth(self.bounds) * 0.8);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.mas_equalTo(200);
    }];
}

#pragma mark - setter and getter
- (HYMainTodayCircleView *)circieView {
    if (!_circieView) {
        _circieView = [[HYMainTodayCircleView alloc] init];
    }
    return _circieView;
}

- (HYMainTodayBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[HYMainTodayBottomView alloc] init];
    }
    return _bottomView;
}

@end
