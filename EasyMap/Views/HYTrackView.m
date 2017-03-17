//
//  HYTrackView.m
//  EasyMap
//
//  Created by hyyy on 2017/3/14.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYTrackView.h"

@interface HYTrackView()

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
}

- (void)initLayout {
    [self.stepCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.top.equalTo(self.mas_top).offset(50);
        make.size.mas_equalTo(CGSizeMake(120, 50));
    }];
}

#pragma mark - Events


#pragma mark - setter and getter
- (UILabel *)stepCountLabel {
    if (!_stepCountLabel) {
        _stepCountLabel = [UILabel new];
        _stepCountLabel.font = [UIFont systemFontOfSize:14.0f];
        _stepCountLabel.textAlignment = NSTextAlignmentCenter;
        _stepCountLabel.textColor = [UIColor redColor];
    }
    return _stepCountLabel;
}

@end
