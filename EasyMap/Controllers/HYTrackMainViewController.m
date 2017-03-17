//
//  HYTrackMainViewController.m
//  EasyMap
//
//  Created by hyyy on 2017/3/7.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYTrackMainViewController.h"
#import "HYTrackView.h"

@interface HYTrackMainViewController ()

@property (nonatomic, strong) HYTrackView *trackView;

@property (nonatomic, strong) CMPedometer *pedometer;

@end

@implementation HYTrackMainViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"轨迹";
    [self.view addSubview:self.trackView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([CMPedometer isStepCountingAvailable]) {
        NSDate *toDate = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *fromDate = [dateFormatter dateFromString:[dateFormatter stringFromDate:toDate]];
        [self.pedometer startPedometerUpdatesFromDate:fromDate withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
            if (!pedometerData.numberOfSteps) {
                self.trackView.stepCountLabel.text = @"0";
            }else {
                self.trackView.stepCountLabel.text = [NSString stringWithFormat:@"%@", pedometerData.numberOfSteps];
            }
        }];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.pedometer stopPedometerUpdates];
}

#pragma mark - Events
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSObject *)userInfo {
}

#pragma mark - setter and getter
- (HYTrackView *)trackView {
    if (!_trackView) {
        _trackView = [[HYTrackView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TAB_BAR_HEIGHT)];
    }
    return _trackView;
}

- (CMPedometer *)pedometer {
    if (!_pedometer) {
        _pedometer = [[CMPedometer alloc] init];
    }
    return _pedometer;
}

@end
