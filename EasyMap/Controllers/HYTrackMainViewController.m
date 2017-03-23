//
//  HYTrackMainViewController.m
//  EasyMap
//
//  Created by hyyy on 2017/3/7.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYTrackMainViewController.h"
#import "HYTrackView.h"
#import "NSDate+YYAdd.h"
#import "Pedometer.h"

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
        // 查询今日步数
        [self queryTodayPedometerDateWithHandler:^(Pedometer *pedometer) {
            NSLog(@"当前线程: %d", [NSThread isMainThread]);
            [self.trackView refreshTodayData:pedometer];
        }];
        // 查询过去7天步数统计
        [self queryWeekPedometerData:^(NSArray<Pedometer *> *pedometerArray) {
            NSLog(@"当前线程: %d", [NSThread isMainThread]);
            [self.trackView refreshLastSevenDayData:pedometerArray];
        }];
    }else {
        [[HYProgressHelper sharedInstance] showToast:@"记步功能不可用"];
    }
}

/**
 查询今日的记步数据

 @param handler 回调
 */
- (void)queryTodayPedometerDateWithHandler:(void (^)(Pedometer *pedometer))handler {
    NSString *startDateStr = [NSString stringWithFormat:@"%@-%@-%@ 00:00:00", [NSDate date].year, [NSDate date].month, [NSDate date].day];
    NSDate *startDate = [NSDate dateWithString:startDateStr format:@"yyyy-MM-dd HH:mm:ss"];
    [self.pedometer startPedometerUpdatesFromDate:startDate withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        Pedometer *pedometer = [[Pedometer alloc] init];
        pedometer.dayDate = [NSDate dateWithString:[NSString stringWithFormat:@"%@-%@-%@ 00:00:00", pedometerData.endDate.year, pedometerData.endDate.month, pedometerData.endDate.day] format:@"yyyy-MM-dd"];
        pedometer.stepCount = [pedometerData.numberOfSteps integerValue];
        pedometer.distance = [pedometerData.distance floatValue];
        pedometer.floorsAscended = [pedometerData.floorsAscended integerValue];
        pedometer.floorsDescended = [pedometerData.floorsDescended integerValue];

        handler(pedometer);
    }];
}

/**
 查询最近7天的记步数据

 @param handler 回调
 */
- (void)queryWeekPedometerData:(void (^)(NSArray<Pedometer *> *pedometerArray))handler {
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (int i = 0; i < 7; i++) {
        NSDate *dayDate = [[NSDate date] dateByAddingDays:-i-1];
        [self queryDayPedometerData:dayDate withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
            Pedometer *pedometer = [[Pedometer alloc] init];
            pedometer.dayDate = [NSDate dateWithString:[NSString stringWithFormat:@"%@-%@-%@ 00:00:00", pedometerData.endDate.year, pedometerData.endDate.month, pedometerData.endDate.day] format:@"yyyy-MM-dd"];
            pedometer.stepCount = [pedometerData.numberOfSteps integerValue];
            pedometer.distance = [pedometerData.distance floatValue];
            pedometer.floorsAscended = [pedometerData.floorsAscended integerValue];
            pedometer.floorsDescended = [pedometerData.floorsDescended integerValue];
            [mutableArray addObject:pedometer];
            if (i == 6) {
                handler([NSArray arrayWithArray:mutableArray]);
            }
        }];
    }
}

/**
 查询一天的记步数据

 @param dayDate 哪一天
 @param handler 回调
 */
- (void)queryDayPedometerData:(NSDate *)dayDate withHandler:(void (^)(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error))handler {
    NSString *fromDateStr = [NSString stringWithFormat:@"%@-%@-%@ 00:00:00", dayDate.year, dayDate.month, dayDate.day];
    NSString *endDateStr = [NSString stringWithFormat:@"%@-%@-%@ 23:59:59", dayDate.year, dayDate.month, dayDate.day];
    NSDate *fromDate = [NSDate dateWithString:fromDateStr format:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *endDate = [NSDate dateWithString:endDateStr format:@"yyyy-MM-dd HH:mm:ss"];
    [self.pedometer queryPedometerDataFromDate:fromDate toDate:endDate withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        handler(pedometerData, error);
    }];
}

#pragma mark - setter and getter
- (HYTrackView *)trackView {
    if (!_trackView) {
        _trackView = [[HYTrackView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TAB_BAR_HEIGHT - STATUS_BAR_HEIGHT - NAVIGATION_BAR_HEIGHT)];
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
