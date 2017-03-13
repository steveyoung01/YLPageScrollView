//
//  YLPageScrollView.h
//  YLPageScrollView
//
//  Created by Youngly on 2017/3/13.
//  Copyright © 2017年 YL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YLPageScrollViewAppreance;

@interface YLPageScrollView : UIView

+ (instancetype)pageScrollView:(CGRect)frame titles:(NSArray *)titles childVCs:(NSArray *)childVCs parentVC:(UIViewController *)parentVC appreance:(YLPageScrollViewAppreance *)appreance;

@end
