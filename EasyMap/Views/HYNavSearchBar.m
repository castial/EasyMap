//
//  HYNavSearchBar.m
//  EasyMap
//
//  Created by hyyy on 2017/2/27.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYNavSearchBar.h"

@interface HYNavSearchBar()

@property (strong, nonatomic) UIButton *searchBtn;

@end

@implementation HYNavSearchBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        [self initUI];
        [self initLayout];
    }
    return self;
}

- (void)initUI {
    [self addSubview:self.searchBtn];
}

- (void)initLayout {
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self);
    }];
}

#pragma mark - setter and getter
- (UIButton *)searchBtn {
    if (!_searchBtn) {
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchBtn.backgroundColor = [UIColor colorWithRed:231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:1.0];
        [_searchBtn setTitleColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    }
    return _searchBtn;
}

- (void)setSearchPlaceHolder:(NSString *)searchPlaceHolder {
    _searchPlaceHolder = searchPlaceHolder;
    if (searchPlaceHolder) {
        [self.searchBtn setTitle:searchPlaceHolder forState:UIControlStateNormal];
    }
}

@end
