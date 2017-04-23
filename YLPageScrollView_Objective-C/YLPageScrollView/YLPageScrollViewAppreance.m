//
//  YLPageScrollViewAppreance.m
//  YLPageScrollView
//
//  Created by Youngly on 2017/3/13.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "YLPageScrollViewAppreance.h"
#import "YLPageScrollViewConfigure.h"

@implementation YLPageScrollViewAppreance
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    
    self.titleFont = [UIFont systemFontOfSize:14];
    self.titleViewHeight = 40.0;
    self.titleOffset = 8;
    self.titleMargin = 20;
    self.botomLineHeight = 3;
    self.maxScaleRatio = 1.15;
    
    self.titleViewColor = [UIColor whiteColor];
    self.titleNormalColor = [UIColor orangeColor];
    self.titleSelectedColor = [UIColor purpleColor];
    self.bottomLineColor = self.titleSelectedColor;
    
    self.isScrollEnable = YES;
    self.isShowBottomLine = YES;
    self.isNeedScale = NO;
}
@end
