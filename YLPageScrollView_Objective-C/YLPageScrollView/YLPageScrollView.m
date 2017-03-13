//
//  YLPageScrollView.m
//  YLPageScrollView
//
//  Created by Youngly on 2017/3/13.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "YLPageScrollView.h"
#import "YLPageScrollViewAppreance.h"

@interface YLPageScrollView ()

@property (nonatomic, strong) NSArray *titles;
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
        
    }
    return self;
}

@end
