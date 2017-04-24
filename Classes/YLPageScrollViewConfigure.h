//
//  YLPageScrollViewConfigure.h
//  YLPageScrollView
//
//  Created by Youngly on 2017/3/13.
//  Copyright © 2017年 YL. All rights reserved.
//

#ifndef YLPageScrollViewConfigure_h
#define YLPageScrollViewConfigure_h


#define YLPageScrollViewSW \
        ([UIScreen mainScreen].bounds.size.width)
#define YLPageScrollViewSH \
        ([UIScreen mainScreen].bounds.size.height)


#define YLPageScrollViewRGBA(r, g, b, a) \
        [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define YLPageScrollViewRGB(r, g, b)\
        YLPageScrollViewRGBA(r, g, b, 1.0)

#define YLPageScrollViewRandomColor \
        YLPageScrollViewRGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))


@class YLPageScrollTitleView;
@class YLPageScrollContentView;

@protocol YLPageScrollTitleViewDelegate <NSObject>
- (void)pageScrollTitleViewDidSelected:(YLPageScrollTitleView *)titleView selectedIndex:(NSInteger)selectedIndex;
@end


@protocol YLPageScrollContentViewDelegate <NSObject>
- (void)contentViewDidEndScroll:(YLPageScrollContentView *)contentView index:(NSUInteger)index;
- (void)contentView:(YLPageScrollContentView *)contentView fromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex progress:(CGFloat)progress;
@end


#endif /* YLPageScrollViewConfigure_h */
