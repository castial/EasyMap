//
//  HYTrackMainViewController.m
//  EasyMap
//
//  Created by hyyy on 2017/3/7.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYTrackMainViewController.h"
#import "HYTrackView.h"

// 一天时间
static NSTimeInterval const kDayTimeInterval = 60 * 60 * 24;

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
    
    [self queryStepCount];
}

#pragma mark - Events
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSObject *)userInfo {
}

#pragma mark - Private Methods
- (void)queryStepCount {
    if ([CMPedometer isStepCountingAvailable]) {
        NSDate *fromDate = [NSDate dateWithTimeIntervalSinceNow:-kDayTimeInterval];
        @weakify(self)
        [self.pedometer startPedometerUpdatesFromDate:fromDate withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
            @strongify(self)
            if (!error) {
                NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithCapacity:3];
                mutableDic[@"step"] = [NSString stringWithFormat:@"%@", pedometerData.numberOfSteps];
                mutableDic[@"distance"] = [NSString stringWithFormat:@"%@", pedometerData.distance];
                mutableDic[@"floors"] = [NSString stringWithFormat:@"%@", pedometerData.floorsAscended];
                [self.trackView reloadData:[NSDictionary dictionaryWithDictionary:mutableDic]];
//                NSLog(@"步数 = %@", pedometerData.numberOfSteps);
//                NSLog(@"距离 = %@", pedometerData.distance);
//                NSLog(@"上楼 = %@", pedometerData.floorsAscended);
//                NSLog(@"下楼 = %@", pedometerData.floorsDescended);
//                NSLog(@"速度/米 = %@", pedometerData.currentPace);
//                NSLog(@"速度/步 = %@", pedometerData.currentCadence);
            }else {
                [[HYProgressHelper sharedInstance] showToast:error.description];
            }
        }];
    }else {
        [[HYProgressHelper sharedInstance] showToast:@"记步功能不可用"];
    }
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
