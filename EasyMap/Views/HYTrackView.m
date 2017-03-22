//
//  HYTrackView.m
//  EasyMap
//
//  Created by hyyy on 2017/3/14.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYTrackView.h"
#import "HYStepDayTableCell.h"

@interface HYTrackView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UILabel *stepCountValueLabel;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UILabel *distanceValueLabel;
@property (nonatomic, strong) UILabel *floorsLabel;
@property (nonatomic, strong) UILabel *floorsValueLabel;

@property (nonatomic, strong) UITableView *tableView;

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
    [self addSubview:self.stepCountLabel];
    [self addSubview:self.stepCountValueLabel];
    [self addSubview:self.distanceLabel];
    [self addSubview:self.distanceValueLabel];
    [self addSubview:self.floorsLabel];
    [self addSubview:self.floorsValueLabel];
    [self addSubview:self.tableView];
}

- (void)initLayout {
    [self.stepCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(20);
        make.size.mas_equalTo(CGSizeMake(200, 50));
    }];
    [self.stepCountValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.stepCountLabel.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(200, 50));
    }];
    [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.stepCountValueLabel.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.size.mas_equalTo(CGSizeMake(CGRectGetWidth(self.frame)/2, 35));
    }];
    [self.distanceValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.distanceLabel.mas_bottom).offset(5);
        make.left.equalTo(self.mas_left);
        make.size.mas_equalTo(CGSizeMake(CGRectGetWidth(self.frame)/2, 35));
    }];
    [self.floorsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.stepCountValueLabel.mas_bottom);
        make.left.equalTo(self.distanceLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake(CGRectGetWidth(self.frame)/2, 35));
    }];
    [self.floorsValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.distanceLabel.mas_bottom).offset(5);
        make.left.equalTo(self.distanceValueLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake(CGRectGetWidth(self.frame)/2, 35));
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.floorsValueLabel.mas_bottom);
        make.left.right.bottom.equalTo(self);
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return [HYStepDayTableCell cellHeight];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    HYStepDayTableCell *cell = [HYStepDayTableCell cellWithTableView:tableView];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Public Methods
- (void)reloadData:(NSDictionary *)dic {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.stepCountValueLabel.text = [dic objectForKey:@"step"];
        self.distanceValueLabel.text = [dic objectForKey:@"distance"];
        self.floorsValueLabel.text = [dic objectForKey:@"floors"];
    });
}

#pragma mark - setter and getter
- (UILabel *)stepCountLabel {
    if (!_stepCountLabel) {
        _stepCountLabel = [UILabel new];
        _stepCountLabel.font = [UIFont systemFontOfSize:30.0f];
        _stepCountLabel.textAlignment = NSTextAlignmentCenter;
        _stepCountLabel.text = @"今日步数";
    }
    return _stepCountLabel;
}

- (UILabel *)stepCountValueLabel {
    if (!_stepCountValueLabel) {
        _stepCountValueLabel = [UILabel new];
        _stepCountValueLabel.font = [UIFont systemFontOfSize:30.0f];
        _stepCountValueLabel.textAlignment = NSTextAlignmentCenter;
        _stepCountValueLabel.textColor = [UIColor lightGrayColor];
        _stepCountValueLabel.text = @"--";
    }
    return _stepCountValueLabel;
}

- (UILabel *)distanceLabel {
    if (!_distanceLabel) {
        _distanceLabel = [UILabel new];
        _distanceLabel.font = [UIFont systemFontOfSize:18.0f];
        _distanceLabel.textAlignment = NSTextAlignmentCenter;
        _distanceLabel.text = @"距离";
    }
    return _distanceLabel;
}

- (UILabel *)distanceValueLabel {
    if (!_distanceValueLabel) {
        _distanceValueLabel = [UILabel new];
        _distanceValueLabel.font = [UIFont systemFontOfSize:18.0f];
        _distanceValueLabel.textAlignment = NSTextAlignmentCenter;
        _distanceValueLabel.textColor = [UIColor lightGrayColor];
        _distanceValueLabel.text = @"--";
    }
    return _distanceValueLabel;
}

- (UILabel *)floorsLabel {
    if (!_floorsLabel) {
        _floorsLabel = [UILabel new];
        _floorsLabel.font = [UIFont systemFontOfSize:18.0f];
        _floorsLabel.textAlignment = NSTextAlignmentCenter;
        _floorsLabel.text = @"楼层";
    }
    return _floorsLabel;
}

- (UILabel *)floorsValueLabel {
    if (!_floorsValueLabel) {
        _floorsValueLabel = [UILabel new];
        _floorsValueLabel.font = [UIFont systemFontOfSize:18.0f];
        _floorsValueLabel.textAlignment = NSTextAlignmentCenter;
        _floorsValueLabel.textColor = [UIColor lightGrayColor];
        _floorsValueLabel.text = @"--";
    }
    return _floorsValueLabel;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
