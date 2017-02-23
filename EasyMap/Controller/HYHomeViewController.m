//
//  HYHomeViewController.m
//  EasyMap
//
//  Created by hyyy on 2017/2/23.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYHomeViewController.h"

@interface HYHomeViewController ()

@property (strong, nonatomic) UILabel *introLabel;

@end

@implementation HYHomeViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.introLabel];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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

#pragma mark - Events
#pragma mark - Public Methods
#pragma mark - Private Methods
#pragma mark - setter and getter
- (UILabel *)introLabel {
    if (!_introLabel) {
        _introLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, 120, 35)];
        _introLabel.textColor = [UIColor lightGrayColor];
        _introLabel.textAlignment = NSTextAlignmentCenter;
        _introLabel.text = @"Easy Map";
        _introLabel.font = [UIFont systemFontOfSize:16.0f];
    }
    return _introLabel;
}

@end
