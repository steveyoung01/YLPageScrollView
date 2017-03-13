//
//  YLPageScrollContentView.h
//  YLPageScrollView
//
//  Created by Youngly on 2017/3/13.
//  Copyright © 2017年 YL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLPageScrollTitleView.h"

@class YLPageScrollViewAppreance;
@class YLPageScrollContentView;
@protocol YLPageScrollTitleViewDelegate;


@protocol YLPageScrollContentViewDelegate <NSObject>

- (void)contentViewDidEndScroll:(YLPageScrollContentView *)contentView index:(NSInteger)index;
- (void)contentView:(YLPageScrollContentView *)contentView fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;

@end

@interface YLPageScrollContentView : UIView <YLPageScrollTitleViewDelegate>

/**
 防止和系统的delegate重名
 */
@property (nonatomic, weak) id<YLPageScrollContentViewDelegate> delegate_;

+ (instancetype)pageScrollContentViewWithFrame:(CGRect)frame childVCs:(NSArray *)childVCs parentVC:(UIViewController *)parentVC appreance:(YLPageScrollViewAppreance *)appreance;

@end
