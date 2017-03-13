//
//  UITableView+EmptyData.m
//  EasyMap
//
//  Created by hyyy on 2017/3/10.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "UITableView+EmptyData.h"

@implementation UITableView (EmptyData)

- (void)hy_tableViewDisplayWithMessage:(NSString *)message ifDataSourceEmpty:(NSUInteger)count {
    if (count == 0) {
        UILabel *emptyDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        emptyDataLabel.text = message;
        emptyDataLabel.textColor = [UIColor lightGrayColor];
        emptyDataLabel.textAlignment = NSTextAlignmentCenter;
        self.backgroundView = emptyDataLabel;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;        
    }
}

@end
