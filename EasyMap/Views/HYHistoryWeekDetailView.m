//
//  HYHistoryWeekDetailView.m
//  EasyMap
//
//  Created by 李洋 on 2017/4/4.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYHistoryWeekDetailView.h"

@interface HYHistoryWeekDetailView()

// 平均
@property (nonatomic, strong) UILabel *averageLabel;
@property (nonatomic, strong) UILabel *averageValueLabel;

// 总
@property (nonatomic, strong) UILabel *totalLabel;
@property (nonatomic, strong) UILabel *totalValueLabel;

@property (nonatomic, strong) PNBarChart *barChart;

@end

@implementation HYHistoryWeekDetailView

#pragma mark - lifecycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        [self initLayout];
    }
    return self;
}

#pragma mark - private methods
/**
 *  初始化UI
 */
- (void)initUI {
    [self addSubview:self.averageLabel];
    [self addSubview:self.averageValueLabel];
    [self addSubview:self.totalLabel];
    [self addSubview:self.totalValueLabel];
    [self addSubview:self.barChart];
}

/**
 *  初始化布局
 */
- (void)initLayout {
    [self.averageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(50);
        make.left.equalTo(self.mas_left);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/2, 20));
    }];
    [self.averageValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.averageLabel.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/2, 35));
    }];
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(50);
        make.right.equalTo(self.mas_right);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/2, 20));
    }];
    [self.totalValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.totalLabel.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/2, 35));
    }];
    [self.barChart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.averageValueLabel.mas_bottom).offset(15);
        make.left.equalTo(self.mas_left).offset(30);
        make.right.equalTo(self.mas_right).offset(-30);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 60, SCREEN_HEIGHT - 200));
    }];
}

#pragma mark - setter and getter
- (UILabel *)averageLabel {
    if (!_averageLabel) {
        _averageLabel = [UILabel new];
        _averageLabel.textAlignment = NSTextAlignmentCenter;
        _averageLabel.font = [UIFont systemFontOfSize:12.0f];
        _averageLabel.text = @"平均步数";
    }
    return _averageLabel;
}

- (UILabel *)averageValueLabel {
    if (!_averageValueLabel) {
        _averageValueLabel = [UILabel new];
        _averageValueLabel.textAlignment = NSTextAlignmentCenter;
        _averageValueLabel.font = [UIFont systemFontOfSize:28.0f];
        _averageValueLabel.text = @"10,344";
    }
    return _averageValueLabel;
}

- (UILabel *)totalLabel {
    if (!_totalLabel) {
        _totalLabel = [UILabel new];
        _totalLabel.textAlignment = NSTextAlignmentCenter;
        _totalLabel.font = [UIFont systemFontOfSize:12.0f];
        _totalLabel.text = @"总步数";
    }
    return _totalLabel;
}

- (UILabel *)totalValueLabel {
    if (!_totalValueLabel) {
        _totalValueLabel = [UILabel new];
        _totalValueLabel.textAlignment = NSTextAlignmentCenter;
        _totalValueLabel.font = [UIFont systemFontOfSize:28.0f];
        _totalValueLabel.text = @"73,133";
    }
    return _totalValueLabel;
}

- (PNBarChart *)barChart {
    if (!_barChart) {
        _barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0,
                                                                 0,
                                                                 SCREEN_WIDTH - 60,
                                                                 SCREEN_HEIGHT - 200)];
        _barChart.isShowNumbers = NO;
//        _barChart.yChartLabelWidth = 0;
        _barChart.chartMarginBottom = 50;
//        _barChart.barWidth = 10;
        _barChart.barBackgroundColor = [UIColor clearColor];
        _barChart.xLabels = @[@"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日"];
        _barChart.yValues = @[@3803, @5800, @7801, @6403, @8500, @3403, @5409];
        [_barChart strokeChart];
    }
    return _barChart;
}

@end
