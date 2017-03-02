//
//  HYSegmentControl.m
//  EasyMap
//
//  Created by hyyy on 2017/3/2.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYSegmentControl.h"

#define kScreenWidth                [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight               [[UIScreen mainScreen] bounds].size.height
static const CGFloat kSegmentHeight = 47;   // 分段视图高度
static const CGFloat kItemHeight = 44;   // item高度
static const CGFloat kIndicatorHeight = 3;   // 下面选中标志高度

@interface HYSegmentControl()

@property (copy, nonatomic) NSArray *titleArray;
@property (assign, nonatomic) NSInteger selectedIndex;
@property (copy, nonatomic) NSMutableArray *buttonArray;
@property (strong, nonatomic) UIView *indicatorView;    // 底部选中标志

@end
@implementation HYSegmentControl

- (instancetype)initWithTitleArray:(NSArray *)titleArray {
    self = [super initWithFrame:CGRectMake(0, 64, kScreenWidth, kSegmentHeight)];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.titleArray = titleArray;
        self.selectedIndex = 0;
        [self initUI];
    }
    return self;
}

- (void)initUI {
    for (int i=0; i<self.titleArray.count; i++) {
        NSString *title = [self.titleArray objectAtIndex:i];
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i*(kScreenWidth/self.titleArray.count), 0, kScreenWidth/self.titleArray.count, kItemHeight)];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        button.tag = i;
        [button addTarget:self action:@selector(selectedCurrentItem:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonArray addObject:button];
        [self addSubview:button];
        
        // 默认
        if (i == 0) {
            button.selected = YES;
        }
    }
    
    // 添加底部选中标志
    [self addSubview:self.indicatorView];
}

#pragma mark - Events
- (void)selectedCurrentItem:(id)sender {
    UIButton *selectedButton = (UIButton *)sender;
    if (self.selectedIndex == selectedButton.tag) {
        return;
    }
    selectedButton.selected = YES;
    UIButton *lastSelectedButton = [self.buttonArray objectAtIndex:self.selectedIndex];
    lastSelectedButton.selected = NO;
    [UIView animateWithDuration:0.2 animations:^{
        [self.indicatorView setFrame:CGRectMake(selectedButton.tag * selectedButton.bounds.size.width, kSegmentHeight - kIndicatorHeight, selectedButton.bounds.size.width, kIndicatorHeight)];
    }];
    self.selectedIndex = selectedButton.tag;
}

#pragma mark - setter and getter
- (UIView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, kSegmentHeight - kIndicatorHeight, kScreenWidth / self.titleArray.count, kIndicatorHeight)];
        _indicatorView.backgroundColor = [UIColor redColor];
    }
    return _indicatorView;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [NSArray array];
    }
    return _titleArray;
}

- (NSMutableArray *)buttonArray {
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

@end
