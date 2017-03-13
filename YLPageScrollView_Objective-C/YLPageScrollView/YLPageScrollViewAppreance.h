//
//  YLPageScrollViewAppreance.h
//  YLPageScrollView
//
//  Created by Youngly on 2017/3/13.
//  Copyright © 2017年 YL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLPageScrollViewAppreance : NSObject

/// 标题文字大小
@property (nonatomic, strong) UIFont *titleFont;
/// 标题滚动视图的高度
@property (nonatomic, assign) CGFloat titleViewHeight;
/// 标题左右距离屏幕的偏移量
@property (nonatomic, assign) CGFloat titleOffset;
/// 标题文字之间的间距
@property (nonatomic, assign) CGFloat titleMargin;
/// 底部线的高度
@property (nonatomic, assign) CGFloat botomLineHeight;
/// 文字缩放系数
@property (nonatomic, assign) CGFloat maxScaleRatio;

/// 标题文字普通颜色
@property (nonatomic, strong) UIColor *titleNormalColor;
/// 标题文字选中颜色
@property (nonatomic, strong) UIColor *titleSelectedColor;
/// 标题底部线的颜色, 默认=titleNormalColor
@property (nonatomic, strong) UIColor *bottomLineColor;

/// 是否允许标题栏滚动
@property (nonatomic, assign) BOOL isScrollEnable;
/// 是否显示底部线
@property (nonatomic, assign) BOOL isShowBottomLine;
/// 是否需要缩放标题
@property (nonatomic, assign) BOOL isNeedScale;

@end
