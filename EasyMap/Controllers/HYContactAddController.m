//
//  HYContactAddController.m
//  EasyMap
//
//  Created by hyyy on 2017/3/10.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYContactAddController.h"
#import "HYContactAddCell.h"
#import "Contact.h"

@interface HYContactAddController ()<UITableViewDelegate, UITableViewDataSource, HYContactAddCellDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (copy, nonatomic) NSArray *introArray;
@property (copy, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) Contact *contact;

@end

@implementation HYContactAddController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加联系人";
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return self.introArray.count;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return [HYContactAddCell cellHeight];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    HYContactAddCell *cell = [HYContactAddCell cellWithTableView:tableView];
    cell.delegate = self;
    cell.title = [self.titleArray objectAtIndex:indexPath.section];
    cell.cellPlaceHolder = [self.introArray objectAtIndex:indexPath.section];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - HYContactAddCellDelegate
- (void)handleTextFieldChanged:(HYContactAddCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if (indexPath.section == 0) {
        // 姓名
        self.contact.contactName = cell.textField.text;
    }else {
        // 电话
        self.contact.contactPhone = cell.textField.text;
    }
}

#pragma mark - setter and getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.scrollEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"姓名", @"手机号"];
    }
    return _titleArray;
}

- (NSArray *)introArray {
    if (!_introArray) {
        _introArray = @[@"请输入姓名", @"请输入手机号"];
    }
    return _introArray;
}

- (Contact *)contact {
    if (!_contact) {
        _contact = [[Contact alloc] init];
    }
    return _contact;
}

@end
