//
//  YLPageScrollContentView.m
//  YLPageScrollView
//
//  Created by Youngly on 2017/3/13.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "YLPageScrollContentView.h"
#import "YLPageScrollViewConfigure.h"
#import "YLPageScrollTitleView.h"

@interface YLPageScrollContentView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) NSArray<UIViewController *> *childVCs;
@property (nonatomic, strong) UIViewController *parentVC;
@property (nonatomic, strong) YLPageScrollViewAppreance *appreance;

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
    
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
}

#pragma mark - YLPageScrollTitleViewDelegate
- (void)pageScrollTitleViewDidSelected:(YLPageScrollTitleView *)titleView selectedIndex:(NSInteger)selectedIndex
{
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
