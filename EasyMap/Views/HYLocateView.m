//
//  HYLocateView.m
//  EasyMap
//
//  Created by hyyy on 2017/3/8.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYLocateView.h"

@interface HYLocateView()

@property (strong, nonatomic) UIButton *locateBtn;

@end

@implementation HYLocateView

#pragma mark - lifecycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        [self initLayout];
    }
    return self;
}

#pragma mark - init UI and Layout
- (void)initUI {
    self.backgroundColor = [UIColor colorWithRed:58.0/255.0 green:155.0/255.0 blue:252.0/255.0 alpha:1.0f];
    [self addSubview:self.locateBtn];
    
    [self.locateBtn addTarget:self action:@selector(clickedLocateBtnHandler) forControlEvents:UIControlEventTouchUpInside];
}

- (void)initLayout {
    [self.locateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(70);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
}

#pragma mark - Events
- (void)clickedLocateBtnHandler {
    if ([self.delegate respondsToSelector:@selector(didSelectLocateBtn)]) {
        [self.delegate didSelectLocateBtn];
    }
}

#pragma mark - setter and getter
- (UIButton *)locateBtn {
    if (!_locateBtn) {
        _locateBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        _locateBtn.backgroundColor = [UIColor colorWithRed:58.0/255.0 green:155.0/255.0 blue:252.0/255.0 alpha:1.0f];
        _locateBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _locateBtn.layer.borderWidth = 2;
        _locateBtn.layer.cornerRadius = 100 / 2;
        _locateBtn.layer.masksToBounds = YES;
    }
    return _locateBtn;
}

@end
