//
//  HYMainTodayBottomView.m
//  EasyMap
//
//  Created by hyyy on 2017/3/28.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYMainTodayBottomView.h"

@interface HYMainTodayBottomView()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end

@implementation HYMainTodayBottomView

#pragma mark - lifecycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self.layer addSublayer:self.shapeLayer];
}

- (void)layoutSubviews {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, CGRectGetHeight(self.bounds) * 0.5)];
    [path addLineToPoint:CGPointMake(0, CGRectGetHeight(self.bounds))];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) * 0.5)];
    [path addCurveToPoint:CGPointMake(0, CGRectGetHeight(self.bounds) * 0.5)
            controlPoint1:CGPointMake(CGRectGetWidth(self.bounds) * 2/3, CGRectGetHeight(self.bounds))
            controlPoint2:CGPointMake(CGRectGetWidth(self.bounds)/3, 0)];
    self.shapeLayer.path = path.CGPath;
}

#pragma mark - setter and getter
- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.fillColor = [UIColor lightGrayColor].CGColor;
        _shapeLayer.strokeColor = [UIColor lightGrayColor].CGColor;
        _shapeLayer.lineWidth = 2;
        _shapeLayer.lineCap = kCALineCapRound;
        _shapeLayer.lineJoin = kCALineJoinRound;
    }
    return _shapeLayer;
}

@end
