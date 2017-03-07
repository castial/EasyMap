//
//  HYNavSearchBar.h
//  EasyMap
//
//  Created by hyyy on 2017/2/27.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HYNavSearchBarDelegate <NSObject>

@optional
- (void)clickedSearchBarHandler;

@end
@interface HYNavSearchBar : UIView

// 搜索提示语
@property (strong, nonatomic) NSString *searchPlaceHolder;

@property (weak, nonatomic) id<HYNavSearchBarDelegate> delegate;

@end
