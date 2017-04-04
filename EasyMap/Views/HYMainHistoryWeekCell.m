//
//  HYMainHistoryWeekCell.m
//  EasyMap
//
//  Created by 李洋 on 2017/4/2.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYMainHistoryWeekCell.h"

static NSString *const kHYMainHistoryWeekCell_ID = @"HYMainHistoryWeekCell";
static CGFloat const kHYMainHistoryWeekCell_Height = 150;

@interface HYMainHistoryWeekCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *valueLabel;

@property (nonatomic, strong) PNBarChart *barChart;

@end

@implementation HYMainHistoryWeekCell

+(NSString *)ID{
    return kHYMainHistoryWeekCell_ID;
}

+(CGFloat)cellHeight{
    return kHYMainHistoryWeekCell_Height;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    // 修改cell类型为定义类型
    HYMainHistoryWeekCell *cell = [tableView dequeueReusableCellWithIdentifier:kHYMainHistoryWeekCell_ID];
    if (cell == nil){
        cell = [[HYMainHistoryWeekCell alloc] init];
        
        // 初始化
        [cell initCellUI];
    }
    return cell;
}

/**
 *  初始化视图
 */
- (void)initCellUI{
    // 初始化Cell视图
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.valueLabel];
    [self.contentView addSubview:self.barChart];
}

- (void)layoutSubviews {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 45));
    }];
    [self.barChart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.valueLabel.mas_right).offset(30);
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-30);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
    }];
}

#pragma mark - setter and getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:14.0f];
        _titleLabel.text = @"呼吸率";
        _titleLabel.textColor = [UIColor lightGrayColor];
    }
    return _titleLabel;
}

- (UILabel *)valueLabel {
    if (!_valueLabel) {
        _valueLabel = [UILabel new];
        _valueLabel.font = [UIFont systemFontOfSize:28.0f];
        _valueLabel.text = @"12,2391";
    }
    return _valueLabel;
}

- (PNBarChart *)barChart {
    if (!_barChart) {
        _barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(150, 10, SCREEN_WIDTH - 160, 150)];
        _barChart.isShowNumbers = NO;
        _barChart.yChartLabelWidth = 0;
        _barChart.chartMarginBottom = 50;
        _barChart.barWidth = 10;
        _barChart.barBackgroundColor = [UIColor clearColor];
        _barChart.xLabels = @[@"一", @"二", @"三", @"四", @"五", @"六", @"日"];
        _barChart.yValues = @[@3803, @5800, @7801, @6403, @8500, @3403, @5409];
        _barChart.displayAnimated = NO;
        [_barChart strokeChart];
    }
    return _barChart;
}

@end
