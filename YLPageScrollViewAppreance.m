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
- (NSArray *)normalColors {
    if (!_normalColors) {
        CGFloat normalRed = 0;
        CGFloat normalGreen = 0;
        CGFloat normalBlue = 0;
        [self.titleNormalColor getRed:&normalRed green:&normalGreen blue:&normalBlue alpha:nil];
        _normalColors = @[@(ABS(normalRed)), @(ABS(normalGreen)), @(ABS(normalBlue))];
    }
    return _normalColors;
}
- (NSArray *)selectedColors {
    if (!_selectedColors) {
        CGFloat normalRed = 0;
        CGFloat normalGreen = 0;
        CGFloat normalBlue = 0;
        [self.titleSelectedColor getRed:&normalRed green:&normalGreen blue:&normalBlue alpha:nil];
        _selectedColors = @[@(ABS(normalRed)), @(ABS(normalGreen)), @(ABS(normalBlue))];
    }
    return _selectedColors;
}

- (NSArray *)deltaColors {
    if (!_deltaColors) {
        _deltaColors = @[@(ABS([self.normalColors[0] doubleValue]-[self.selectedColors[0] doubleValue])), @(ABS([self.normalColors[1] doubleValue]-[self.selectedColors[1] doubleValue])), @(ABS([self.normalColors[2] doubleValue]-[self.selectedColors[2] doubleValue]))];
    }
    return _deltaColors;
}
@end
