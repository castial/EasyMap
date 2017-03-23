//
//  HYStepDayTableCell.m
//  EasyMap
//
//  Created by hyyy on 2017/3/22.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYStepDayTableCell.h"
#import "Pedometer.h"

static NSString *const HYStepDayTableCell_ID = @"HYStepDayTableCell";
static CGFloat const HYStepDayTableCell_Height = 140;

@interface HYStepDayTableCell()

@property (nonatomic, strong) UILabel *dayLabel;
@property (nonatomic, strong) UILabel *weekLabel;
@property (nonatomic, strong) UILabel *stepLabel;
@property (nonatomic, strong) UILabel *stepValueLabel;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UILabel *distanceValueLabel;
@property (nonatomic, strong) UILabel *floorsLabel;
@property (nonatomic, strong) UILabel *floorsValueLabel;

@end
@implementation HYStepDayTableCell

+(NSString *)ID{
    return HYStepDayTableCell_ID;
}

+(CGFloat)cellHeight{
    return HYStepDayTableCell_Height;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    // 修改cell类型为定义类型
    HYStepDayTableCell *cell = [tableView dequeueReusableCellWithIdentifier:HYStepDayTableCell_ID];
    if (cell == nil){
        // 初始化UI
        cell = [[HYStepDayTableCell alloc] init];
        [cell initCellUI];
        [cell initCellLayout];
    }
    return cell;
}

// 初始化Cell视图
- (void)initCellUI{
    [self.contentView addSubview:self.dayLabel];
    [self.contentView addSubview:self.weekLabel];
    [self.contentView addSubview:self.stepLabel];
    [self.contentView addSubview:self.stepValueLabel];
    [self.contentView addSubview:self.distanceLabel];
    [self.contentView addSubview:self.distanceValueLabel];
    [self.contentView addSubview:self.floorsLabel];
    [self.contentView addSubview:self.floorsValueLabel];
}

// 初始化Cell布局
- (void)initCellLayout {
    [self.dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).offset(-10);
        make.left.equalTo(self.mas_left).offset(30);
        make.size.mas_equalTo(CGSizeMake(70, 40));
    }];
    [self.weekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(30);
        make.top.equalTo(self.dayLabel.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(70, 40));
    }];
    [self.stepLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dayLabel.mas_right).offset(10);
        make.top.equalTo(self.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(70, 35));
    }];
    [self.stepValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.stepLabel.mas_right).offset(10);
        make.top.equalTo(self.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(120, 35));
    }];
    [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dayLabel.mas_right).offset(10);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(70, 35));
    }];
    [self.distanceValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.distanceLabel.mas_right).offset(10);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(120, 35));
    }];
    [self.floorsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dayLabel.mas_right).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.size.mas_equalTo(CGSizeMake(70, 35));
    }];
    [self.floorsValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.floorsLabel.mas_right).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.size.mas_equalTo(CGSizeMake(120, 35));
    }];
}

#pragma mark - setter and getter
- (UILabel *)dayLabel {
    if (!_dayLabel) {
        _dayLabel = [UILabel new];
        _dayLabel.textAlignment = NSTextAlignmentCenter;
        _dayLabel.font = [UIFont boldSystemFontOfSize:20];
        _dayLabel.text = @"3月1日";
    }
    return _dayLabel;
}

- (UILabel *)weekLabel {
    if (!_weekLabel) {
        _weekLabel = [UILabel new];
        _weekLabel.textAlignment = NSTextAlignmentCenter;
        _weekLabel.font = [UIFont boldSystemFontOfSize:15];
        _weekLabel.text = @"星期一";
    }
    return _weekLabel;
}

- (UILabel *)stepLabel {
    if (!_stepLabel) {
        _stepLabel = [UILabel new];
        _stepLabel.font = [UIFont systemFontOfSize:14];
        _stepLabel.text = @"步数";
    }
    return _stepLabel;
}

- (UILabel *)stepValueLabel {
    if (!_stepValueLabel) {
        _stepValueLabel = [UILabel new];
        _stepValueLabel.font = [UIFont systemFontOfSize:14];
        _stepValueLabel.textColor = [UIColor lightGrayColor];
    }
    return _stepValueLabel;
}

- (UILabel *)distanceLabel {
    if (!_distanceLabel) {
        _distanceLabel = [UILabel new];
        _distanceLabel.font = [UIFont systemFontOfSize:14];
        _distanceLabel.text = @"距离";
    }
    return _distanceLabel;
}

- (UILabel *)distanceValueLabel {
    if (!_distanceValueLabel) {
        _distanceValueLabel = [UILabel new];
        _distanceValueLabel.font = [UIFont systemFontOfSize:14];
        _distanceValueLabel.textColor = [UIColor lightGrayColor];
    }
    return _distanceValueLabel;
}

- (UILabel *)floorsLabel {
    if (!_floorsLabel) {
        _floorsLabel = [UILabel new];
        _floorsLabel.font = [UIFont systemFontOfSize:14];
        _floorsLabel.text = @"楼层";
    }
    return _floorsLabel;
}

- (UILabel *)floorsValueLabel {
    if (!_floorsValueLabel) {
        _floorsValueLabel = [UILabel new];
        _floorsValueLabel.font = [UIFont systemFontOfSize:14];
        _floorsValueLabel.textColor = [UIColor lightGrayColor];
    }
    return _floorsValueLabel;
}

- (void)setCellData:(Pedometer *)cellData {
    _cellData = cellData;
    
    if (cellData) {
        self.stepValueLabel.text = [NSString stringWithFormat:@"%ld", cellData.stepCount];
        self.distanceValueLabel.text = [NSString stringWithFormat:@"%.2f", cellData.distance];
        self.floorsValueLabel.text = [NSString stringWithFormat:@"%ld", cellData.floorsAscended];
    }
}

@end
