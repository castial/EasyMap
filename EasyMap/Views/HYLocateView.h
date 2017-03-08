//
//  HYLocateView.h
//  EasyMap
//
//  Created by hyyy on 2017/3/8.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HYLocateViewDelegate <NSObject>

@optional
- (void)didSelectLocateBtn;

@end

@interface HYLocateView : UIView

@property (weak, nonatomic) id<HYLocateViewDelegate> delegate;

@end
