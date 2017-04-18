//
//  YLPageScrollContentView.m
//  YLPageScrollView
//
//  Created by Youngly on 2017/3/13.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "YLPageScrollContentView.h"
#import "YLPageScrollTitleView.h"

@interface YLPageScrollContentView () <YLPageScrollTitleViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) NSArray<UIViewController *> *childVCs;
@property (nonatomic, strong) UIViewController *parentVC;
@property (nonatomic, strong) YLPageScrollViewAppreance *appreance;
@property (nonatomic, assign) CGFloat startOffsetX;
@property (nonatomic, assign) BOOL isForbidDelegate;
//@property (nonatomic, assign) BOOL isEndDecelerate;
@property (nonatomic, assign) NSUInteger indexWhenScrollToLeft;

@end


@implementation YLPageScrollContentView
static NSString * const cellId = @"UICollectionViewCell";

+ (instancetype)pageScrollContentViewWithFrame:(CGRect)frame childVCs:(NSArray *)childVCs parentVC:(UIViewController *)parentVC appreance:(YLPageScrollViewAppreance *)appreance
{
    return [[self alloc] initWithFrame:frame childVCs:childVCs parentVC:parentVC appreance:appreance];
}

- (instancetype)initWithFrame:(CGRect)frame childVCs:(NSArray *)childVCs parentVC:(UIViewController *)parentVC appreance:(YLPageScrollViewAppreance *)appreance
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = YLPageScrollViewRandomColor;
        self.isForbidDelegate = NO;
        self.indexWhenScrollToLeft = 0;
        
        self.childVCs = childVCs;
        self.appreance = appreance;
        self.parentVC = parentVC;
        
        [self addSubview:self.collectionView];
    }
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.childVCs.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    for (UIView *view in cell.subviews) {
        [view removeFromSuperview];
    }
    [cell addSubview:self.childVCs[indexPath.row].view];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    if (contentOffsetX == self.startOffsetX || self.isForbidDelegate) {
        return;
    }
    NSUInteger sourceIndex = 0;
    NSUInteger targetIndex = 0;
    CGFloat progress = 0;
    CGFloat scrollViewWidth = scrollView.bounds.size.width;
    if (contentOffsetX > self.startOffsetX) { // 向左滑动
        sourceIndex = (contentOffsetX) / scrollViewWidth;
        targetIndex = sourceIndex + 1;
        if (targetIndex > self.childVCs.count - 1) {
            targetIndex = self.childVCs.count - 1;
        }
        if (sourceIndex - self.indexWhenScrollToLeft == 1) {
            targetIndex = sourceIndex;
        }
//        NSLog(@"%f, %f", contentOffsetX, self.startOffsetX);
        NSLog(@"%lu, %lu", sourceIndex, targetIndex);
    } else { // 向右滑动
        
        targetIndex = contentOffsetX / scrollViewWidth;
        sourceIndex = targetIndex + 1;
        if (self.startOffsetX - contentOffsetX == scrollViewWidth) {
            sourceIndex = targetIndex;
        }
        NSLog(@"%lu, %lu", sourceIndex, targetIndex);
        NSLog(@"%f, %f", contentOffsetX, self.startOffsetX);
    }
    progress = ABS(contentOffsetX-self.startOffsetX) / scrollViewWidth;
    if (!self.isForbidDelegate && [self.delegate_ respondsToSelector:@selector(contentView:fromIndex:toIndex:progress:)]) {
        [self.delegate_ contentView:self fromIndex:sourceIndex toIndex:targetIndex progress:progress];
    }
    self.indexWhenScrollToLeft = sourceIndex;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.isForbidDelegate = NO;
    self.startOffsetX = scrollView.contentOffset.x;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScroll];
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    NSLog(@"%s", __func__);
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        [self scrollViewDidEndScroll];
    } else {
        
    }
}
- (void)scrollViewDidEndScroll
{
    if ([self.delegate_ respondsToSelector:@selector(contentViewDidEndScroll:index:)]) {
        NSUInteger index = self.collectionView.contentOffset.x / self.frame.size.width;
        [self.delegate_ contentViewDidEndScroll:self index:index];
    }
}

#pragma mark - YLPageScrollTitleViewDelegate
- (void)pageScrollTitleViewDidSelected:(YLPageScrollTitleView *)titleView selectedIndex:(NSInteger)selectedIndex
{
    self.isForbidDelegate = YES;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:kNilOptions animated:NO];
}

#pragma mark - 懒加载
- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [UICollectionViewFlowLayout new];
        _layout.minimumLineSpacing = 0;
        _layout.minimumInteritemSpacing = 0;
        _layout.itemSize = self.bounds.size;
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _layout;
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.layout];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellId];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
    }
    return _collectionView;
}
@end
