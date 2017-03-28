//
//  HYMainTodayCircleView.m
//  EasyMap
//
//  Created by hyyy on 2017/3/27.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYMainTodayCircleView.h"

@interface HYMainTodayCircleView()

@property (nonatomic, strong) CAShapeLayer *backgroundShapeLayer;
@property (nonatomic, strong) CAShapeLayer *progressShapeLayer;

@property (nonatomic, strong) UILabel *todayStepLabel;
@property (nonatomic, strong) UILabel *todayStepValueLabel;
@property (nonatomic, strong) UILabel *targetLabel;

@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UILabel *distanceValueLabel;

@property (nonatomic, strong) UILabel *calLabel;
@property (nonatomic, strong) UILabel *calValueLabel;

@property (nonatomic, strong) UILabel *floorsLabel;
@property (nonatomic, strong) UILabel *floorsValueLabel;

@end

@implementation HYMainTodayCircleView

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
    [self addSubview:self.todayStepLabel];
    [self addSubview:self.todayStepValueLabel];
    [self addSubview:self.targetLabel];
    
    [self.layer addSublayer:self.backgroundShapeLayer];
    [self.layer addSublayer:self.progressShapeLayer];
    
    [self addSubview:self.distanceLabel];
    [self addSubview:self.distanceValueLabel];
    
    [self addSubview:self.calLabel];
    [self addSubview:self.calValueLabel];
    
    [self addSubview:self.floorsLabel];
    [self addSubview:self.floorsValueLabel];
}

- (void)layoutSubviews {
    // 计算半径、开始角度和结束角度
    CGFloat radius = 100;
    
    // (弧度=π/180×角度,M_PI弧度代表180角度).
    CGFloat startAngle = M_PI * 112.5 / 180;
    CGFloat endAngle = M_PI * 427.5390 / 180;
    CGFloat endProgressAngle = M_PI * (112.5 + (427.5-112.5) * 0.5) / 180;
    
    // 画背景圆环
    UIBezierPath *backgroundPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds)/2 - 20) radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    self.backgroundShapeLayer.path = backgroundPath.CGPath;
    
    // 画进度圆环
    UIBezierPath *progressPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds)/2 - 20) radius:radius startAngle:startAngle endAngle:endProgressAngle clockwise:YES];
    self.progressShapeLayer.path = progressPath.CGPath;
    [self addAnimationWithLayer:self.progressShapeLayer duration:1.0];
    
    // 今日步数
    [self.todayStepLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.todayStepValueLabel.mas_top).offset(-5);
        make.size.mas_equalTo(CGSizeMake(120, 20));
    }];
    [self.todayStepValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(-20);
        make.size.mas_equalTo(CGSizeMake(150, 35));
    }];
    [self.targetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.todayStepValueLabel.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    // 距离
    [self.distanceValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
        make.size.mas_equalTo(CGSizeMake(CGRectGetWidth(self.frame)/3, 30));
    }];
    [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.distanceValueLabel.mas_top).offset(-2);
        make.size.mas_equalTo(CGSizeMake(CGRectGetWidth(self.frame)/3, 30));
    }];
    
    // 卡里路
    [self.calValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.distanceValueLabel.mas_right);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
        make.size.mas_equalTo(CGSizeMake(CGRectGetWidth(self.frame)/3, 30));
    }];
    [self.calLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.distanceLabel.mas_right);
        make.bottom.equalTo(self.distanceValueLabel.mas_top).offset(-2);
        make.size.mas_equalTo(CGSizeMake(CGRectGetWidth(self.frame)/3, 30));
    }];
    
    // 楼层
    [self.floorsValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
        make.size.mas_equalTo(CGSizeMake(CGRectGetWidth(self.frame)/3, 30));
    }];
    [self.floorsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.floorsValueLabel.mas_top).offset(-2);
        make.size.mas_equalTo(CGSizeMake(CGRectGetWidth(self.frame)/3, 30));
    }];
}

#pragma mark - Private Methods
- (void)addAnimationWithLayer:(CAShapeLayer *)layer duration:(CFTimeInterval)duration {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(0);
    animation.toValue = @(1);
    animation.duration = duration;
    [layer addAnimation:animation forKey:nil];
}

#pragma mark - setter and getter
- (CAShapeLayer *)backgroundShapeLayer {
    if (!_backgroundShapeLayer) {
        _backgroundShapeLayer = [CAShapeLayer layer];
        _backgroundShapeLayer.lineWidth = 10;
        _backgroundShapeLayer.lineCap = kCALineCapRound;
        _backgroundShapeLayer.lineJoin = kCALineJoinRound;
        _backgroundShapeLayer.strokeColor = [UIColor lightGrayColor].CGColor;
        _backgroundShapeLayer.fillColor = [UIColor clearColor].CGColor;
    }
    return _backgroundShapeLayer;
}

- (CAShapeLayer *)progressShapeLayer {
    if (!_progressShapeLayer) {
        _progressShapeLayer = [CAShapeLayer layer];
        _progressShapeLayer.lineWidth = 10;
        _progressShapeLayer.lineCap = kCALineCapRound;
        _progressShapeLayer.lineJoin = kCALineJoinRound;
        _progressShapeLayer.strokeColor = [UIColor redColor].CGColor;
        _progressShapeLayer.fillColor = [UIColor clearColor].CGColor;
    }
    return _progressShapeLayer;
}

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
        _todayStepValueLabel.font = [UIFont systemFontOfSize:28.0f];
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

- (UILabel *)distanceLabel {
    if (!_distanceLabel) {
        _distanceLabel = [UILabel new];
        _distanceLabel.font = [UIFont systemFontOfSize:14.0f];
        _distanceLabel.text = @"距离";
        _distanceLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _distanceLabel;
}

- (UILabel *)distanceValueLabel {
    if (!_distanceValueLabel) {
        _distanceValueLabel = [UILabel new];
        _distanceValueLabel.font = [UIFont systemFontOfSize:14.0f];
        _distanceValueLabel.text = @"1202.0";
        _distanceValueLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _distanceValueLabel;
}

- (UILabel *)calLabel {
    if (!_calLabel) {
        _calLabel = [UILabel new];
        _calLabel.font = [UIFont systemFontOfSize:14.0f];
        _calLabel.text = @"卡路里";
        _calLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _calLabel;
}

- (UILabel *)calValueLabel {
    if (!_calValueLabel) {
        _calValueLabel = [UILabel new];
        _calValueLabel.font = [UIFont systemFontOfSize:14.0f];
        _calValueLabel.text = @"230";
        _calValueLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _calValueLabel;
}

- (UILabel *)floorsLabel {
    if (!_floorsLabel) {
        _floorsLabel = [UILabel new];
        _floorsLabel.font = [UIFont systemFontOfSize:14.0f];
        _floorsLabel.text = @"距离";
        _floorsLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _floorsLabel;
}

- (UILabel *)floorsValueLabel {
    if (!_floorsValueLabel) {
        _floorsValueLabel = [UILabel new];
        _floorsValueLabel.font = [UIFont systemFontOfSize:14.0f];
        _floorsValueLabel.text = @"10";
        _floorsValueLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _floorsValueLabel;
}

@end
