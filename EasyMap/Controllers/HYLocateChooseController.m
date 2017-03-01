//
//  HYLocateChooseController.m
//  EasyMap
//
//  Created by hyyy on 2017/3/1.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYLocateChooseController.h"
#import <MessageUI/MessageUI.h>

@interface HYLocateChooseController ()<UITableViewDelegate, UITableViewDataSource, MFMessageComposeViewControllerDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSIndexPath *selectIndexPath; // 选中的indexPath

@end

@implementation HYLocateChooseController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择位置";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(clickedBackBtnHandler)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(clickedSendBtnHandler)];
    
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 1 : self.poiList.count;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 50;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0f];
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    }
    BMKPoiInfo *poiInfo = [self.poiList objectAtIndex:indexPath.row];
    cell.textLabel.text = poiInfo.name;
    cell.detailTextLabel.text = poiInfo.address;
    
    // 首个显示详细位置
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.textLabel.text = @"当前位置";
        cell.detailTextLabel.text = self.addressDescription;
    }
    // 勾选对号
    if ([self.selectIndexPath isEqual:indexPath]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    
    self.selectIndexPath = indexPath;
    [self.tableView reloadData];
}

#pragma mark - MFMessageComposeViewControllerDelegate
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    // 关闭短信界面
    [controller dismissViewControllerAnimated:YES completion:nil];
    if (result == MessageComposeResultCancelled) {
        NSLog(@"短信取消发送");
    }else if (result == MessageComposeResultSent) {
        NSLog(@"短信发送成功");
    }else {
        NSLog(@"短信发送失败");
    }
}

#pragma mark - Events
- (void)clickedBackBtnHandler {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)clickedSendBtnHandler {
    // 获取短信内容
    NSString *messageBody;
    if (self.selectIndexPath.section == 0) {
        messageBody = self.addressDescription;
    }else {
        BMKPoiInfo *poiInfo = [self.poiList objectAtIndex:self.selectIndexPath.row];
        messageBody = [NSString stringWithFormat:@"%@(%@)", poiInfo.address, poiInfo.name];
    }
    MFMessageComposeViewController *messageVC = [[MFMessageComposeViewController alloc] init];
    messageVC.body = messageBody;
    messageVC.messageComposeDelegate = self;
    [self presentViewController:messageVC animated:YES completion:nil];
}

#pragma mark - Public Methods
#pragma mark - Private Methods
#pragma mark - setter and getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSString *)addressDescription {
    if (!_addressDescription) {
        _addressDescription = [NSString string];
    }
    return _addressDescription;
}

- (NSArray<BMKPoiInfo *> *)poiList {
    if (!_poiList) {
        _poiList = [NSArray array];
    }
    return _poiList;
}

- (NSIndexPath *)selectIndexPath {
    if (!_selectIndexPath) {
        _selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    return _selectIndexPath;
}

@end
