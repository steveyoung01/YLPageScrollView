//
//  YLPageScrollTitleView.h
//  YLPageScrollView
//
//  Created by Youngly on 2017/3/13.
//  Copyright © 2017年 YL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLPageScrollViewConfigure.h"


@class YLPageScrollViewAppreance;

@interface YLPageScrollTitleView : UIScrollView <YLPageScrollContentViewDelegate>

/**
 防止和系统的delegate重名
 */
@property (nonatomic, weak) id<YLPageScrollTitleViewDelegate> delegate_;

+ (instancetype)pageScrollTitleViewWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles appreance:(YLPageScrollViewAppreance *)appreance;

@end
