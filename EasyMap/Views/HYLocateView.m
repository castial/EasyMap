//
//  HYLocateView.m
//  EasyMap
//
//  Created by hyyy on 2017/3/8.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYLocateView.h"
#import "UIImage+Utils.h"

@interface HYLocateView()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UIView *locateHeaderView;
@property (strong, nonatomic) UIButton *locateBtn;
@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) CAShapeLayer *shapeLayer;

@end

@implementation HYLocateView

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
    [self.locateHeaderView addSubview:self.locateBtn];
    [self addSubview:self.locateHeaderView];
    [self addSubview:self.tableView];
    [self.locateBtn.layer addSublayer:self.shapeLayer];
}

- (void)initLayout {
    [self.locateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.locateHeaderView.mas_centerX);
        make.centerY.equalTo(self.locateHeaderView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(155, 155));
    }];
    [self.locateHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(300);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.top.equalTo(self.locateHeaderView.mas_bottom);
    }];
}

#pragma mark - Public Methods
- (void)startLocateAnimation {
    self.shapeLayer.strokeEnd = 0.9;
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    basicAnimation.fromValue = 0;
    basicAnimation.toValue = @(M_PI * 2);
    basicAnimation.duration = 1;
    basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    basicAnimation.repeatCount = INFINITY;
    [self.shapeLayer addAnimation:basicAnimation forKey:@"infinity_rotate"];
}

- (void)endLocateAnimation {
    self.shapeLayer.strokeEnd = 1;
    [self.shapeLayer removeAnimationForKey:@"infinity_rotate"];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 44;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"使用说明";
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Events
- (void)clickedLocateBtnHandler {
    if ([self.delegate respondsToSelector:@selector(didSelectLocateBtn)]) {
        [self.delegate didSelectLocateBtn];
    }
}

#pragma mark - setter and getter
- (UIButton *)locateBtn {
    if (!_locateBtn) {
        _locateBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
        _locateBtn.layer.cornerRadius = 150 / 2;
        [_locateBtn addTarget:self action:@selector(clickedLocateBtnHandler) forControlEvents:UIControlEventTouchUpInside];
    }
    return _locateBtn;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UIView *)locateHeaderView {
    if (!_locateHeaderView) {
        _locateHeaderView = [[UIView alloc] init];
        _locateHeaderView.backgroundColor = [UIColor colorWithRed:58.0/255.0 green:155.0/255.0 blue:252.0/255.0 alpha:1.0f];
    }
    return _locateHeaderView;
}

- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        CGFloat radius = 150;   // 圆形直径
        CGRect frame = CGRectMake(0, 0, radius, radius);
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.frame = frame;
        _shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;
        
        // 画圆
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:frame];
        _shapeLayer.path = path.CGPath;
        _shapeLayer.lineWidth = 2;
        _shapeLayer.lineCap = kCALineCapRound;  // 线条结尾的样子
        _shapeLayer.strokeStart = 0;
        _shapeLayer.strokeEnd = 1;
    }
    return _shapeLayer;
}

@end
