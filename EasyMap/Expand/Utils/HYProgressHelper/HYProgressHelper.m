//
//  HYProgressHelper.m
//  EasyMap
//
//  Created by hyyy on 2017/3/9.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYProgressHelper.h"
#import "MBProgressHUD.h"

@interface HYProgressHelper()

@property (strong, nonatomic) MBProgressHUD *progressHub;

@end

@implementation HYProgressHelper
#pragma mark - LifeCycle
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static HYProgressHelper *instance;
    dispatch_once(&onceToken, ^{
        instance = [[HYProgressHelper alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.progressHub = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
        self.progressHub.removeFromSuperViewOnHide = NO;
        [[UIApplication sharedApplication].keyWindow addSubview:self.progressHub];
    }
    return self;
}

#pragma mark - Public Methods
- (void)showLoading:(NSString *)text {
    self.progressHub.label.text = text;
    self.progressHub.mode = MBProgressHUDModeIndeterminate;
    [self.progressHub showAnimated:YES];
}

- (void)hideLoading {
    [self.progressHub hideAnimated:YES];
}

- (void)showToast:(NSString *)text {
    self.progressHub.label.text = text;
    self.progressHub.mode = MBProgressHUDModeText;
    [self.progressHub showAnimated:YES];
    
    // 两秒后消失
    [self.progressHub hideAnimated:YES afterDelay:2];
}

@end
