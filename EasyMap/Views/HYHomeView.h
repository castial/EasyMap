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
    HYOperateItemNone = 10000,    // 默认不做任何操作
    HYOperateItemLocate,    // 定位功能按钮
    HYOperateItemNavigate,  // 导航功能按钮
    HYOperateItemMe,        // 我的页面按钮
} HYOperateItem;

@protocol HYHomeOperateDelegate <NSObject>

@optional
- (void)clickedHomeOperateBtnHandler:(HYOperateItem)itemType;

@end
@interface HYHomeView : UIView

@property (strong, nonatomic) BMKMapView *mapView;

@property (weak, nonatomic) id<HYHomeOperateDelegate> delegate;

@end
