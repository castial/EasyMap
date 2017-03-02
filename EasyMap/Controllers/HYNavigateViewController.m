//
//  HYNavigateViewController.m
//  EasyMap
//
//  Created by hyyy on 2017/3/2.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYNavigateViewController.h"
#import "HYSegmentControl.h"

@interface HYNavigateViewController ()

@property (strong, nonatomic) HYSegmentControl *segmentControl;

@end

@implementation HYNavigateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(clickedLeftButtonHandler)];
    self.title = @"路线";
    [self.view addSubview:self.segmentControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Events
- (void)clickedLeftButtonHandler {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - setter and getter
- (HYSegmentControl *)segmentControl {
    if (!_segmentControl) {
        _segmentControl = [[HYSegmentControl alloc] initWithTitleArray:@[@"第一", @"第二", @"第三"]];
    }
    return _segmentControl;
}

@end
