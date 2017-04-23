//
//  YLPageScrollView.h
//  YLPageScrollView
//
//  Created by Youngly on 2017/3/13.
//  Copyright © 2017年 YL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLPageScrollTitleView.h"
#import "YLPageScrollContentView.h"

@class YLPageScrollViewAppreance;

@interface YLPageScrollView : UIView

@property (nonatomic, weak, readonly) YLPageScrollTitleView *titleView;
@property (nonatomic, weak, readonly) YLPageScrollContentView *contentView;

+ (instancetype)pageScrollView:(CGRect)frame titles:(NSArray *)titles childVCs:(NSArray *)childVCs parentVC:(UIViewController *)parentVC appreance:(YLPageScrollViewAppreance *)appreance;

@end
