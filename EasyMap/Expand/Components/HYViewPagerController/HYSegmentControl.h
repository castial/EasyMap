//
//  HYSegmentControl.h
//  EasyMap
//
//  Created by hyyy on 2017/3/2.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HYSegmentControl;
@protocol HYSegmentControlDelegate <NSObject>

/**
 选中某个item事件

 @param segmentControl segmentControl
 @param selectedIndex item下标
 */
- (void)segmentControlDidChange:(HYSegmentControl *)segmentControl selectedIndex:(NSInteger)selectedIndex;

@end
@interface HYSegmentControl : UIView

// 标题数组
@property (copy, nonatomic) NSArray *titleArray;

@property (weak, nonatomic) id<HYSegmentControlDelegate> delegate;

/**
 底部选中栏滑动

 @param progress 比例
 */
- (void)indicatorFrameDidChange:(CGFloat)progress;

/**
 选中该下标的item

 @param index 下标
 */
- (void)selectedItem:(NSInteger)index;

@end
