//
//  YLPageScrollTitleView.h
//  YLPageScrollView
//
//  Created by Youngly on 2017/3/13.
//  Copyright © 2017年 YL. All rights reserved.
//

#import <UIKit/UIKit.h>


@class YLPageScrollViewAppreance;

@interface YLPageScrollTitleView : UIScrollView

+ (instancetype)pageScrollTitleViewWithFrame:(CGRect)frame titles:(NSArray *)titles appreance:(YLPageScrollViewAppreance *)appreance;

@end
