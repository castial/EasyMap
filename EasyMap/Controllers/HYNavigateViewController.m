//
//  HYNavigateViewController.m
//  EasyMap
//
//  Created by hyyy on 2017/3/2.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYNavigateViewController.h"

@interface HYNavigateViewController ()

@end

@implementation HYNavigateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(clickedLeftButtonHandler)];
    self.title = @"路线";
    
    self.view.backgroundColor = [UIColor blueColor];
    
    UIViewController *vc1 = [[UIViewController alloc] init];
    vc1.title = @"第一";
    vc1.view.backgroundColor = [UIColor whiteColor];
    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.title = @"第二";
    vc2.view.backgroundColor = [UIColor redColor];
    UIViewController *vc3 = [[UIViewController alloc] init];
    vc3.title = @"第三";
    vc3.view.backgroundColor = [UIColor orangeColor];
    self.viewControllers = @[vc1, vc2, vc3];
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

@end
