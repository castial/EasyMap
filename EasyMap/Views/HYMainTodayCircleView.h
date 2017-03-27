//
//  HYMainTodayCircleView.h
//  EasyMap (百分比圆环)
//
//  Created by hyyy on 2017/3/27.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYMainTodayCircleView : UIView

/**
 开始角度
 */
@property (nonatomic, assign) CGFloat startAngle;
/**
 结束角度
 */
@property (nonatomic, assign) CGFloat endAngle;
/**
 圆环线宽
 */
@property (nonatomic, assign) CGFloat lineWidth;
/**
 圆环线条背景颜色
 */
@property (nonatomic, strong) UIColor *backgroundFillColor;
/**
 圆环填充颜色
 */
@property (nonatomic, strong) UIColor *fillColor;

@end
