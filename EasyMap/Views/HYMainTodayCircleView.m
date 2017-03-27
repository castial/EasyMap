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

@end

@implementation HYMainTodayCircleView

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
    [self.layer addSublayer:self.backgroundShapeLayer];
    [self.layer addSublayer:self.progressShapeLayer];
}

- (void)initLayout {
}

#pragma mark - setter and getter
- (CAShapeLayer *)backgroundShapeLayer {
    if (!_backgroundShapeLayer) {
        _backgroundShapeLayer = [CAShapeLayer layer];
        _backgroundShapeLayer.lineWidth = 30;
        _backgroundShapeLayer.lineCap = kCALineCapRound;
        _backgroundShapeLayer.lineJoin = kCALineJoinRound;
        _backgroundShapeLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    }
    return _backgroundShapeLayer;
}

- (CAShapeLayer *)progressShapeLayer {
    if (!_progressShapeLayer) {
        _progressShapeLayer = [CAShapeLayer layer];
        _progressShapeLayer.lineWidth = 30;
        _progressShapeLayer.lineCap = kCALineCapRound;
        _progressShapeLayer.lineJoin = kCALineJoinRound;
        _progressShapeLayer.strokeColor = [UIColor redColor].CGColor;
    }
    return _progressShapeLayer;
}

@end
