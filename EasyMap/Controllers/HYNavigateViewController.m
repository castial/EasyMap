//
//  HYNavigateViewController.m
//  EasyMap
//
//  Created by hyyy on 2017/3/2.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYNavigateViewController.h"
#import "HYSearchViewController.h"
#import "HYWalkQueryController.h"
#import "HYRideQueryController.h"

@interface HYNavigateViewController ()

@end

@implementation HYNavigateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"路线";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back@3x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(clickedLeftItemHandler)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(pushHandler)];
    
    HYWalkQueryController *walkVC = [[HYWalkQueryController alloc] init];
    HYRideQueryController *rideVC = [[HYRideQueryController alloc] init];
    self.viewControllers = @[walkVC, rideVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Events
- (void)clickedLeftItemHandler {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)pushHandler {
    HYSearchViewController *searchVC = [[HYSearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

#pragma mark - setter and getter

@end
