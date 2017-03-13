//
//  YLPageScrollView.m
//  YLPageScrollView
//
//  Created by Youngly on 2017/3/13.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "YLPageScrollView.h"
#import "YLPageScrollViewAppreance.h"
#import "YLPageScrollTitleView.h"
#import "YLPageScrollContentView.h"

@interface YLPageScrollView ()

@property (nonatomic, weak) YLPageScrollTitleView *titleView;
@property (nonatomic, weak) YLPageScrollContentView *contentView;

@property (nonatomic, strong) NSArray *childVCs;
@property (nonatomic, strong) UIViewController *parentVC;
@property (nonatomic, strong) YLPageScrollViewAppreance *appreance;

@end


@implementation YLPageScrollView

+ (instancetype)pageScrollView:(CGRect)frame titles:(NSArray *)titles childVCs:(NSArray *)childVCs parentVC:(UIViewController *)parentVC appreance:(YLPageScrollViewAppreance *)appreance {
    return [[self alloc] initWithFrame:frame titles:titles childVCs:childVCs parentVC:parentVC appreance:appreance];
}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles childVCs:(NSArray *)childVCs parentVC:(UIViewController *)parentVC appreance:(YLPageScrollViewAppreance *)appreance {
    if (self = [super initWithFrame:frame]) {
        
        YLPageScrollTitleView *titleView = [YLPageScrollTitleView pageScrollTitleViewWithFrame:CGRectMake(0, 0, frame.size.width, appreance.titleViewHeight) titles:titles appreance:appreance];
        self.titleView = titleView;
        [self addSubview:titleView];
        
        
        YLPageScrollContentView *contentView = [YLPageScrollContentView pageScrollContentViewWithFrame:CGRectMake(0, appreance.titleViewHeight, frame.size.width, frame.size.height-appreance.titleViewHeight) childVCs:childVCs parentVC:parentVC appreance:appreance];
        self.contentView = contentView;
        [self addSubview:contentView];
        
        titleView.delegate_ = contentView;
        contentView.delegate_ = titleView;
    }
    return self;
}
@end
