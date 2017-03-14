//
//  HYContactAddCell.h
//  EasyMap
//
//  Created by hyyy on 2017/3/10.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HYContactAddEditingChanged @"HYContactAddEditingChanged"    // 文本框内容改变

@class HYContactAddCell;

@interface HYContactAddCell : UITableViewCell

+(NSString *)ID;

+(CGFloat)cellHeight;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (strong, nonatomic) UITextField *textField;

@property (strong, nonatomic) UILabel *titleLabel;

@end
