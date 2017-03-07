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
        self.backgroundColor = [UIColor clearColor];
        [self initUI];
        [self initLayout];
    }
    return self;
}

- (void)initUI {
    [self addSubview:self.searchBtn];
    
    // Event
    [self.searchBtn addTarget:self action:@selector(searchHandler) forControlEvents:UIControlEventTouchUpInside];
}

- (void)initLayout {
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self);
    }];
}

#pragma mark - Events
- (void)searchHandler {
    if ([self.delegate respondsToSelector:@selector(clickedSearchBarHandler)]) {
        [self.delegate clickedSearchBarHandler];
    }
}

#pragma mark - setter and getter
- (UIButton *)searchBtn {
    if (!_searchBtn) {
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchBtn.backgroundColor = [UIColor colorWithRed:231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:1.0];
        [_searchBtn setTitleColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_searchBtn setTitleColor:[UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1.0f] forState:UIControlStateHighlighted];
        _searchBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        _searchBtn.layer.cornerRadius = 4;
        _searchBtn.layer.masksToBounds = YES;
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
