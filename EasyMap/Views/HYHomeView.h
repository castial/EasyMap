//
//  HYHomeView.h
//  EasyMap
//
//  Created by hyyy on 2017/2/27.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import <UIKit/UIKit.h>

// 操作视图中按钮功能类型
typedef enum : NSUInteger {
    HYOperateButtonNone = 10000,    // 默认不做任何操作
    HYOperateButtonSend,    // 发送功能按钮
} HYOperateButton;

@protocol HYHomeOperateDelegate <NSObject>

@optional
- (void)clickedHomeOperateBtnHandler:(HYOperateButton)buttonType;

@end
@interface HYHomeView : UIView

@property (strong, nonatomic) BMKMapView *mapView;

@property (weak, nonatomic) id<HYHomeOperateDelegate> delegate;

@end
