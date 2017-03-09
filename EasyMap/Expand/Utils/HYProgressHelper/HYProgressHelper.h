//
//  HYProgressHelper.h
//  EasyMap
//
//  Created by hyyy on 2017/3/9.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYProgressHelper : NSObject

// 单例方法
+ (instancetype)sharedInstance;

// 显示loading画面
- (void)showLoading:(NSString *)text;
// 隐藏loading画面
- (void)hideLoading;
// 显示类似toast的界面，时间两秒
- (void)showToast:(NSString *)text;

@end
