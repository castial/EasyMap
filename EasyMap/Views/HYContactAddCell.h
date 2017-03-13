//
//  HYContactAddCell.h
//  EasyMap
//
//  Created by hyyy on 2017/3/10.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HYContactAddCell;
@protocol HYContactAddCellDelegate <NSObject>

@optional
- (void)handleTextFieldChanged:(HYContactAddCell *)cell;

@end

@interface HYContactAddCell : UITableViewCell

+(NSString *)ID;

+(CGFloat)cellHeight;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (strong, nonatomic) UITextField *textField;

@property (strong, nonatomic) UILabel *titleLabel;

@property (weak, nonatomic) id<HYContactAddCellDelegate> delegate;

@property (copy, nonatomic) NSString *title;

@property (copy, nonatomic) NSString *cellPlaceHolder;


@end
