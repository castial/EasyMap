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

@interface HYContactAddController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (copy, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) Contact *contact;

@end

@implementation HYContactAddController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加联系人";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(clickedContactDoneHandler)];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return [HYContactAddCell cellHeight];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    HYContactAddCell *cell = [HYContactAddCell cellWithTableView:tableView];
    cell.titleLabel.text = [self.titleArray objectAtIndex:indexPath.row];
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

#pragma mark - Events
- (void)hy_routerEventWithName:(HYControlEvent)eventName userInfo:(NSObject *)userInfo {
    HYContactAddCell *cell = (HYContactAddCell *)userInfo;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if (indexPath.row == 0) {
        // 姓名
        self.contact.contactName = cell.textField.text;
    }else {
        // 电话
        self.contact.contactPhone = cell.textField.text;
    }
}

- (void)clickedContactDoneHandler {
    if (self.contact.contactName.length == 0) {
        [[HYProgressHelper sharedInstance] showToast:@"联系人姓名不能为空"];
        return;
    }
    if (self.contact.contactPhone.length == 0) {
#pragma mark - TODO(添加手机号校验)
        [[HYProgressHelper sharedInstance] showToast:@"联系人手机号不能为空"];
        return;
    }
    @weakify(self)
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        @strongify(self)
        [[RLMRealm defaultRealm] addOrUpdateObject:self.contact];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark - setter and getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.scrollEnabled = NO;
        _tableView.separatorInset = UIEdgeInsetsZero;
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

- (Contact *)contact {
    if (!_contact) {
        _contact = [[Contact alloc] init];
    }
    return _contact;
}

@end
