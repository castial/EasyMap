//
//  HYContactAddCell.m
//  EasyMap
//
//  Created by hyyy on 2017/3/10.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYContactAddCell.h"

static NSString *const HYContactAddCell_ID = @"HYContactAddCell";
static CGFloat const HYContactAddCell_Height = 44;

@implementation HYContactAddCell

+(NSString *)ID{
    return HYContactAddCell_ID;
}

+(CGFloat)cellHeight{
    return HYContactAddCell_Height;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    // 修改cell类型为定义类型
    HYContactAddCell *cell = [tableView dequeueReusableCellWithIdentifier:HYContactAddCell_ID];
    if (cell == nil){
        // 初始化UI
        cell = [[HYContactAddCell alloc] init];
        [cell initCellUI];
        [cell initCellLayout];
    }
    return cell;
}

// 初始化Cell视图
- (void)initCellUI{
    [self addSubview:self.textField];
    [self addSubview:self.titleLabel];
}

// 初始化Cell布局
- (void)initCellLayout {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(5);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(75);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.bottom.equalTo(self);
        make.right.equalTo(self.mas_right).offset(-10);
    }];
}

#pragma mark - Events
- (void)textFieldDidChanged {
    if ([self.delegate respondsToSelector:@selector(handleTextFieldChanged:)]) {
        [self.delegate handleTextFieldChanged:self];
    }
}

#pragma mark - setter and getter
- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.font = [UIFont systemFontOfSize:14.0f];
        [_textField addTarget:self action:@selector(textFieldDidChanged) forControlEvents:UIControlEventValueChanged];
    }
    return _textField;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    return _titleLabel;
}

- (void)setCellPlaceHolder:(NSString *)cellPlaceHolder {
    _cellPlaceHolder = cellPlaceHolder;
    
    if (cellPlaceHolder) {
        self.textField.placeholder = cellPlaceHolder;
    }
}

@end
