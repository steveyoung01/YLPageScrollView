//
//  YLPageScrollTitleView.m
//  YLPageScrollView
//
//  Created by Youngly on 2017/3/13.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "YLPageScrollTitleView.h"
#import "YLPageScrollViewConfigure.h"

@implementation YLPageScrollTitleView

+ (instancetype)pageScrollTitleViewWithFrame:(CGRect)frame titles:(NSArray *)titles appreance:(YLPageScrollViewAppreance *)appreance
{
    return [[self alloc] initWithFrame:frame titles:titles appreance:appreance];
}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles appreance:(YLPageScrollViewAppreance *)appreance
{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = YLPageScrollViewRandomColor;
        
    }
    return self;
}

@end
