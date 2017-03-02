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
    
    [self.view addSubview:self.segmentControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setter and getter
- (HYSegmentControl *)segmentControl {
    if (!_segmentControl) {
        _segmentControl = [[HYSegmentControl alloc] initWithTitleArray:@[@"第一", @"第二", @"第三"]];
    }
    return _segmentControl;
}

@end
