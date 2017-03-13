//
//  HYContactGroupController.m
//  EasyMap
//
//  Created by hyyy on 2017/3/9.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYContactGroupController.h"
#import "HYContactAddController.h"
#import "UITableView+EmptyData.h"
#import "Contact.h"

@interface HYContactGroupController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) RLMResults<Contact *> *dataArray;

@end

@implementation HYContactGroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"联系人";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(clickedAddContactHandler)];
    
    [self.view addSubview:self.tableView];
    [self fetchContacts];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    [tableView hy_tableViewDisplayWithMessage:@"暂无数据" ifDataSourceEmpty:self.dataArray.count];
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 44;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    Contact *contact = [self.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = contact.contactName;
    cell.detailTextLabel.text = contact.contactPhone;
    cell.accessoryType = contact.isSelected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.dataArray.count == 0) {
        return 0.1f;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Contact *contact = [self.dataArray objectAtIndex:indexPath.row];
    // 修改选中状态, 更新UI
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:YES];
}

#pragma mark - Events
- (void)clickedAddContactHandler {
    HYContactAddController *addVC = [[HYContactAddController alloc] init];
    [self.navigationController pushViewController:addVC animated:YES];
}

#pragma mark - Private Methods
- (void)fetchContacts {
    self.dataArray = [Contact allObjects];
    [self.tableView reloadData];
}

#pragma mark - setter and getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
