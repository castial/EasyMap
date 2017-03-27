//
//  HYMainTodayView.m
//  EasyMap
//
//  Created by hyyy on 2017/3/27.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYMainTodayView.h"

@interface HYMainTodayView()

@property (nonatomic, strong) UILabel *todayStepLabel;
@property (nonatomic, strong) UILabel *todayStepValueLabel;
@property (nonatomic, strong) UILabel *targetLabel;

@end

@implementation HYMainTodayView

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
    [self addSubview:self.todayStepLabel];
    [self addSubview:self.todayStepValueLabel];
    [self addSubview:self.targetLabel];
}

- (void)initLayout {
    [self.todayStepLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(100);
        make.size.mas_equalTo(CGSizeMake(120, 20));
    }];
    [self.todayStepValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.todayStepLabel.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(120, 35));
    }];
    [self.targetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.todayStepValueLabel.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
}

#pragma mark - setter and getter
- (UILabel *)todayStepLabel {
    if (!_todayStepLabel) {
        _todayStepLabel = [UILabel new];
        _todayStepLabel.font = [UIFont systemFontOfSize:12.0f];
        _todayStepLabel.text = @"今日步数";
        _todayStepLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _todayStepLabel;
}

- (UILabel *)todayStepValueLabel {
    if (!_todayStepValueLabel) {
        _todayStepValueLabel = [UILabel new];
        _todayStepValueLabel.font = [UIFont systemFontOfSize:24.0f];
        _todayStepValueLabel.textAlignment = NSTextAlignmentCenter;
        _todayStepValueLabel.text = @"3952";
    }
    return _todayStepValueLabel;
}

- (UILabel *)targetLabel {
    if (!_targetLabel) {
        _targetLabel = [UILabel new];
        _targetLabel.font = [UIFont systemFontOfSize:12.0f];
        _targetLabel.text = @"目标  10000";
        _targetLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _targetLabel;
}

@end
