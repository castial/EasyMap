//
//  UIViewController+Present.h
//  EasyMap(当present，添加默认导航栏)
//
//  Created by hyyy on 2017/3/1.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Present)

// present后添加导航栏效果
- (void)hy_presentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^ __nullable)(void))completion;

@end
