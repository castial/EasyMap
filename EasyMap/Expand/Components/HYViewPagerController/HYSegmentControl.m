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

@property (assign, nonatomic) NSInteger selectedIndex;
@property (copy, nonatomic) NSMutableArray *buttonArray;
@property (strong, nonatomic) UIView *indicatorView;    // 底部选中标志

@end
@implementation HYSegmentControl

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setupUI {
    [self.titleArray enumerateObjectsUsingBlock:^(NSString*  _Nonnull title, NSUInteger index, BOOL * _Nonnull stop) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(index * (kScreenWidth/self.titleArray.count), 0, kScreenWidth/self.titleArray.count, kItemHeight)];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        button.tag = index;
        [button addTarget:self action:@selector(selectedCurrentItem:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonArray addObject:button];
        [self addSubview:button];
        
        // 默认
        if (index == 0) {
            button.selected = YES;
        }
    }];
    // 添加底部选中标志
    [self addSubview:self.indicatorView];
}

#pragma mark - Public Methods
- (void)indicatorFrameDidChange:(CGFloat)progress {
    CGRect newFrame = self.indicatorView.frame;
    newFrame.origin.x = (self.selectedIndex + progress) * (kScreenWidth / self.titleArray.count);
    self.indicatorView.frame = newFrame;
}

- (void)selectedItem:(NSInteger)index {
    UIButton *lastSelectedButton = [self.buttonArray objectAtIndex:self.selectedIndex];
    lastSelectedButton.selected = NO;
    if (self.selectedIndex == index) {
        // item复位
        lastSelectedButton.selected = YES;
        [UIView animateWithDuration:0.2 animations:^{
            self.indicatorView.frame = CGRectMake(lastSelectedButton.tag * lastSelectedButton.bounds.size.width,kSegmentHeight - kIndicatorHeight,
                                                  lastSelectedButton.bounds.size.width,
                                                  kIndicatorHeight);
        }];
        return;
    }
    UIButton *selectedButton = [self.buttonArray objectAtIndex:index];
    selectedButton.selected = YES;
    [UIView animateWithDuration:0.2 animations:^{
        [self.indicatorView setFrame:CGRectMake(selectedButton.tag * selectedButton.bounds.size.width,
                                                kSegmentHeight - kIndicatorHeight,
                                                selectedButton.bounds.size.width,
                                                kIndicatorHeight)];
    }];
    self.selectedIndex = index;
    
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(segmentControlDidChange:selectedIndex:)]) {
        [self.delegate segmentControlDidChange:self selectedIndex:self.selectedIndex];
    }
}

#pragma mark - Events
- (void)selectedCurrentItem:(id)sender {
    UIButton *selectedButton = (UIButton *)sender;
    
    [self selectedItem:selectedButton.tag];
}

#pragma mark - setter and getter
- (UIView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, kSegmentHeight - kIndicatorHeight, kScreenWidth / self.titleArray.count, kIndicatorHeight)];
        _indicatorView.backgroundColor = [UIColor redColor];
    }
    return _indicatorView;
}

- (NSMutableArray *)buttonArray {
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

- (void)setTitleArray:(NSArray *)titleArray {
    _titleArray = titleArray;
    
    // 根据数组制定UI
    [self setupUI];
}

@end
