//
//  UITableView+EmptyData.h
//  EasyMap
//
//  Created by hyyy on 2017/3/10.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (EmptyData)

- (void)hy_tableViewDisplayWithMessage:(NSString *)message ifDataSourceEmpty:(NSUInteger)count;

@end
