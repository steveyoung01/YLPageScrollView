//
//  YLPageScrollContentView.m
//  YLPageScrollView
//
//  Created by Youngly on 2017/3/13.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "YLPageScrollContentView.h"
#import "YLPageScrollViewConfigure.h"

@interface YLPageScrollContentView ()
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@end


@implementation YLPageScrollContentView

+ (instancetype)pageScrollContentViewWithFrame:(CGRect)frame childVCs:(NSArray *)childVCs parentVC:(UIViewController *)parentVC appreance:(YLPageScrollViewAppreance *)appreance
{
    return [[self alloc] initWithFrame:frame childVCs:childVCs parentVC:parentVC appreance:appreance];
}

- (instancetype)initWithFrame:(CGRect)frame childVCs:(NSArray *)childVCs parentVC:(UIViewController *)parentVC appreance:(YLPageScrollViewAppreance *)appreance
{
    self.layout.itemSize = frame.size;
    if (self = [super initWithFrame:frame collectionViewLayout:self.layout]) {
        
        self.backgroundColor = YLPageScrollViewRandomColor;
        
    }
    return self;
}

#pragma mark - 懒加载
- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [UICollectionViewFlowLayout new];
        _layout.minimumLineSpacing = 0;
        _layout.minimumInteritemSpacing = 0;
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _layout;
}
@end
