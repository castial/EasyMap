//
//  HYLocateViewController.m
//  EasyMap
//
//  Created by hyyy on 2017/3/1.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYLocateViewController.h"
#import <MessageUI/MessageUI.h>

@interface HYLocateViewController ()<UITableViewDelegate, UITableViewDataSource, MFMessageComposeViewControllerDelegate, BMKShareURLSearchDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSIndexPath *selectIndexPath; // 选中的indexPath

// 短串分享
@property (strong, nonatomic) BMKShareURLSearch *shareSearch;

@end

@implementation HYLocateViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择位置";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back@3x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(clickedLeftItemHandler)];
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
    if (self.poiList.count > 0) {
        BMKPoiInfo *poiInfo = [self.poiList objectAtIndex:indexPath.row];
        cell.textLabel.text = poiInfo.name;
        cell.detailTextLabel.text = poiInfo.address;
    }
    
    // 首个显示详细位置
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.textLabel.text = self.currentLocation.address;
        cell.detailTextLabel.text = self.currentLocation.sematicDescription;
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

#pragma mark - BMKShareURLSearchDelegate
- (void)onGetPoiDetailShareURLResult:(BMKShareURLSearch *)searcher result:(BMKShareURLResult *)result errorCode:(BMKSearchErrorCode)error {
    
    [self.hy_hub hideAnimated:YES];
    if (error == BMK_SEARCH_NO_ERROR) {
        NSString *url = result.url;
        
        // 获取短信内容，发送短信
        BMKPoiInfo *poiInfo = [self.poiList objectAtIndex:self.selectIndexPath.row];
        NSString *messageBody = [NSString stringWithFormat:@"%@(%@)，点击%@查看", poiInfo.address, poiInfo.name, url];
        [self sendMessage:messageBody];
    }else {
        NSLog(@"抱歉，未找到结果");
    }
}

- (void)onGetLocationShareURLResult:(BMKShareURLSearch *)searcher result:(BMKShareURLResult *)result errorCode:(BMKSearchErrorCode)error {
    
    [self.hy_hub hideAnimated:YES];
    if (error == BMK_SEARCH_NO_ERROR) {
        NSString *url = result.url;
        
        // 获取短信内容，发送短信
        NSString *messageBody = [NSString stringWithFormat:@"%@(%@)，点击查看%@", self.currentLocation.address, self.currentLocation.sematicDescription, url];
        [self sendMessage:messageBody];
    }else {
        NSLog(@"抱歉，未找到结果");
    }
}

#pragma mark - MFMessageComposeViewControllerDelegate
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    // 关闭短信界面
    [controller dismissViewControllerAnimated:YES completion:nil];
    if (result == MessageComposeResultCancelled) {
        NSLog(@"短信取消发送");
    }else if (result == MessageComposeResultSent) {
        NSLog(@"短信发送成功");
        [self dismissViewControllerAnimated:YES completion:nil];
    }else {
        NSLog(@"短信发送失败");
    }
}

#pragma mark - Events
- (void)clickedLeftItemHandler {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)clickedSendBtnHandler {
    
    self.hy_hub.label.text = @"正在获取分享短串，请稍后...";
    [self.hy_hub showAnimated:YES];
    // 获取分享短串
    if (self.selectIndexPath.section == 0) {
        BMKLocationShareURLOption *locationShare = [[BMKLocationShareURLOption alloc] init];
        locationShare.snippet = self.currentLocation.address;
        locationShare.name = self.currentLocation.sematicDescription;
        locationShare.location = self.currentLocation.location;
        BOOL flag = [self.shareSearch requestLocationShareURL:locationShare];
        if (!flag) {
            NSLog(@"位置信息分享URL检索失败");
        }
        return;
    }
    BMKPoiDetailShareURLOption *detailShare = [[BMKPoiDetailShareURLOption alloc] init];
    BMKPoiInfo *poiInfo = [self.poiList objectAtIndex:self.selectIndexPath.row];
    detailShare.uid = poiInfo.uid;
    BOOL flag = [self.shareSearch requestPoiDetailShareURL:detailShare];
    if (!flag) {
        NSLog(@"位置信息分享URL检索失败");
    }
}

#pragma mark - Public Methods
#pragma mark - Private Methods

/**
 发送短信

 @param messageBody 短信内容
 */
- (void)sendMessage:(NSString *)messageBody {
    MFMessageComposeViewController *messageVC = [[MFMessageComposeViewController alloc] init];
    messageVC.body = messageBody;
    messageVC.messageComposeDelegate = self;
    [self presentViewController:messageVC animated:YES completion:nil];
}

#pragma mark - setter and getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (BMKReverseGeoCodeResult *)currentLocation {
    if (!_currentLocation) {
        _currentLocation = [[BMKReverseGeoCodeResult alloc] init];
    }
    return _currentLocation;
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

- (BMKShareURLSearch *)shareSearch {
    if (!_shareSearch) {
        _shareSearch = [[BMKShareURLSearch alloc] init];
        _shareSearch.delegate = self;
    }
    return _shareSearch;
}

@end
