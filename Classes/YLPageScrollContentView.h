//
//  YLPageScrollContentView.h
//  YLPageScrollView
//
//  Created by Youngly on 2017/3/13.
//  Copyright © 2017年 YL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLPageScrollViewConfigure.h"


@class YLPageScrollViewAppreance;
@protocol YLPageScrollContentViewDelegate;

@interface YLPageScrollContentView : UIView <YLPageScrollTitleViewDelegate>

/**
 防止和系统的delegate重名
 */
@property (nonatomic, weak) id<YLPageScrollContentViewDelegate> delegate_;

+ (instancetype)pageScrollContentViewWithFrame:(CGRect)frame childVCs:(NSArray *)childVCs parentVC:(UIViewController *)parentVC appreance:(YLPageScrollViewAppreance *)appreance;

@end
