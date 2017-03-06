//
//  HYViewPagerController.m
//  EasyMap
//
//  Created by hyyy on 2017/3/2.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import "HYViewPagerController.h"
#import "HYSegmentControl.h"

static const CGFloat kSegmentHeight = 47;   // 默认分段视图高度

@interface HYViewPagerController ()<UIScrollViewDelegate, HYSegmentControlDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) HYSegmentControl *segmentControl;

@property (copy, nonatomic) NSMutableArray *titleArray;     // 标题数组
@property (assign, nonatomic) NSUInteger selectedIndex;    // 选中的下标

@end

@implementation HYViewPagerController
#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.segmentControl];
    [self.view addSubview:self.scrollView];
    
    // 监听scrollView的contentOffset
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)dealloc {
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)setupSubViews {
    [self.viewControllers enumerateObjectsUsingBlock:^(UIViewController * _Nonnull childVC, NSUInteger index, BOOL * _Nonnull stop) {
        // 修改子控制器视图的frame
        childVC.view.frame = CGRectMake(index * CGRectGetWidth(self.scrollView.frame),
                                        0,
                                        CGRectGetWidth(self.scrollView.frame),
                                        CGRectGetHeight(self.scrollView.frame));
        // 添加子视图和子控制器
        [self addChildViewController:childVC];
        [self.scrollView addSubview:childVC.view];
        // 添加标题
        NSAssert(childVC.title, @"每个控制器必须设置title值");
        [self.titleArray addObject:childVC.title];
        
    }];
    // 完成后，定制头部items
    self.segmentControl.titleArray = self.titleArray;
}

#pragma mark - Events and KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"] && !self.scrollView.isDecelerating && self.scrollView.isDragging) {
        CGPoint contentOffset = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
        CGFloat progress = (contentOffset.x - self.selectedIndex * CGRectGetWidth(self.scrollView.frame)) / CGRectGetWidth(self.scrollView.frame);
        // 添加顶部选中下标动画
        [self.segmentControl indicatorFrameDidChange:progress];
    }
}

#pragma mark - HYSegmentControlDelegate
- (void)segmentControlDidChange:(HYSegmentControl *)segmentControl selectedIndex:(NSInteger)selectedIndex {
    // 将scrollView移到该item位置
    CGPoint contentOffset = self.scrollView.contentOffset;
    contentOffset.x = selectedIndex * CGRectGetWidth(self.scrollView.frame);
    [self.scrollView setContentOffset:contentOffset animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    scrollView.userInteractionEnabled = YES;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    CGFloat targetX = targetContentOffset->x;
    self.selectedIndex = targetX / CGRectGetWidth(scrollView.frame);
    // 修改顶部选中的item
    [self.segmentControl selectedItem:self.selectedIndex];
}

#pragma mark - setter and getter
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        CGFloat y = self.navigationController ? 64 : 20;
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, y + CGRectGetHeight(self.segmentControl.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - (y + CGRectGetHeight(self.segmentControl.frame)))];
        _scrollView.bounces = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (HYSegmentControl *)segmentControl {
    if (!_segmentControl) {
        CGFloat y = self.navigationController ? 64 : 20;
        _segmentControl = [[HYSegmentControl alloc] initWithFrame:CGRectMake(0,
                                                                             y,
                                                                             CGRectGetWidth(self.view.frame),
                                                                             kSegmentHeight)];
        _segmentControl.delegate = self;
    }
    return _segmentControl;
}

- (NSMutableArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

- (void)setViewControllers:(NSArray *)viewControllers {
    _viewControllers = viewControllers;
    
    // 使用前先去除掉所有子控制器
    [self.childViewControllers enumerateObjectsUsingBlock:^(UIViewController*  _Nonnull childVC, NSUInteger index, BOOL * _Nonnull stop) {
        [childVC removeFromParentViewController];
        
    }];
    
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame) * viewControllers.count, CGRectGetHeight(self.scrollView.frame));
    
    // 添加子视图
    [self setupSubViews];
    
}

@end
