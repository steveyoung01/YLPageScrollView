//
//  YLPageScrollTitleView.m
//  YLPageScrollView
//
//  Created by Youngly on 2017/3/13.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "YLPageScrollTitleView.h"
#import "YLPageScrollViewAppreance.h"
#import "YLPageScrollContentView.h"

@interface YLPageScrollTitleView () 
@property (nonatomic, strong) NSArray<NSString *> *titles;
@property (nonatomic, strong) NSMutableArray<UILabel *> *titleLabels;
@property (nonatomic, strong) YLPageScrollViewAppreance *appreance;
@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, assign) NSInteger selectedIndex;
@end


@implementation YLPageScrollTitleView

+ (instancetype)pageScrollTitleViewWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles appreance:(YLPageScrollViewAppreance *)appreance
{
    return [[self alloc] initWithFrame:frame titles:titles appreance:appreance];
}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles appreance:(YLPageScrollViewAppreance *)appreance
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = self.appreance.titleViewColor;
        self.showsHorizontalScrollIndicator = NO;
        self.appreance = appreance;
        self.titles = titles;
        
        for (NSInteger i=0; i<titles.count; i++) {
            UILabel *titleLabel = [UILabel new];
            [self.titleLabels addObject:titleLabel];
            titleLabel.text = titles[i];
            titleLabel.textColor = appreance.titleNormalColor;
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.font = appreance.titleFont;
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.tag = i;
            titleLabel.userInteractionEnabled = YES;
            [titleLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleLabelClick:)]];
            [self addSubview:titleLabel];
            if (i == 0) titleLabel.textColor = appreance.titleSelectedColor;
            
            CGFloat X = 0;
            CGFloat Y = 0;
            CGFloat W = 0;
            CGFloat H = appreance.titleViewHeight;
            if (appreance.isScrollEnable) {
                W = [titles[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : appreance.titleFont} context:nil].size.width;
                X = i==0?appreance.titleOffset : appreance.titleMargin+CGRectGetMaxX(_titleLabels[i-1].frame);
            } else {
                W = YLPageScrollViewSW / titles.count;
                X = W * i;
            }
            titleLabel.frame = CGRectMake(X, Y, W, H);
            
            self.contentSize = CGSizeMake(CGRectGetMaxX([self.titleLabels lastObject].frame) + appreance.titleOffset, appreance.titleViewHeight);
        }
        
        [self addSubview:self.bottomLine];
    }
    return self;
}

#pragma mark - YLPageScrollContentViewDelegate
- (void)contentViewDidEndScroll:(YLPageScrollContentView *)contentView index:(NSUInteger)index
{
    UILabel *lastLabel = self.titleLabels[self.selectedIndex];
    lastLabel.textColor = self.appreance.titleNormalColor;
    self.titleLabels[index].textColor = self.appreance.titleSelectedColor;
    self.selectedIndex = index;
    [self updateSelectedLabelPosition];
}
- (void)contentView:(YLPageScrollContentView *)contentView fromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex progress:(CGFloat)progress
{
    UILabel *sourceLabel = self.titleLabels[fromIndex];
    UILabel *targetLabel = self.titleLabels[toIndex];
 
    CGFloat normalRed = 0;
    CGFloat normalGreen = 0;
    CGFloat normalBlue = 0;
    [self.appreance.titleNormalColor getRed:&normalRed green:&normalGreen blue:&normalBlue alpha:nil];
    CGFloat selectRed = 0;
    CGFloat selectGreen = 0;
    CGFloat selectBlue = 0;
    [self.appreance.titleSelectedColor getRed:&selectRed green:&selectGreen blue:&selectBlue alpha:nil];
    sourceLabel.textColor = [UIColor colorWithRed:selectRed - progress*(selectRed-normalRed) green:selectGreen - progress*(selectGreen-normalGreen) blue:selectBlue - progress*(selectBlue-normalBlue) alpha:1.0];
    targetLabel.textColor = [UIColor colorWithRed:normalRed + progress*(selectRed-normalRed) green:normalGreen + progress*(selectGreen-normalGreen) blue:normalBlue + progress*(selectBlue-normalBlue) alpha:1.0];
    
    // 缩放的变化
    if (self.appreance.isNeedScale) {
        CGFloat deltaScale = self.appreance.maxScaleRatio - 1.0;
        sourceLabel.transform = CGAffineTransformMakeScale(self.appreance.maxScaleRatio - deltaScale * progress, self.appreance.maxScaleRatio - deltaScale * progress);
        targetLabel.transform = CGAffineTransformMakeScale(1 + deltaScale * progress, 1 + deltaScale * progress);
    }
    
    // 计算bottomLine的width/x变化
    CGFloat deltaWidth = CGRectGetWidth(targetLabel.frame) - CGRectGetWidth(sourceLabel.frame);
    CGFloat deltaX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x;
    if (self.appreance.isShowBottomLine) {
        self.bottomLine.frame = CGRectMake(CGRectGetMinX(sourceLabel.frame) + progress*deltaX, self.bottomLine.frame.origin.y, deltaWidth*progress + sourceLabel.frame.size.width, self.appreance.titleViewHeight);
    }
}
- (void)updateSelectedLabelPosition
{
    UILabel *selectedLabel = self.titleLabels[self.selectedIndex];
    CGFloat offsetX = selectedLabel.center.x - self.frame.size.width * 0.5;
    if (offsetX <= 0) {
        offsetX = 0;
    }
    CGFloat maxOffsetX = self.contentSize.width - self.frame.size.width;
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
    if (self.appreance.isShowBottomLine) {
        CGFloat labelW = [selectedLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, self.appreance.titleFont.capHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.appreance.titleFont} context:nil].size.width;
        [UIView animateWithDuration:0.2 animations:^{
            self.bottomLine.frame = CGRectMake(CGRectGetMinX(selectedLabel.frame), CGRectGetMaxY(self.frame) - self.appreance.botomLineHeight, labelW, self.appreance.botomLineHeight);
        }];
    }
}

#pragma mark - 监听titleLabel的点击
- (void)titleLabelClick:(UITapGestureRecognizer *)tap {
    UILabel *selectedLabel = (UILabel *)tap.view;
    if (selectedLabel == self.titleLabels[self.selectedIndex]) return;
    
    self.titleLabels[self.selectedIndex].textColor = self.appreance.titleNormalColor;
    selectedLabel.textColor = self.appreance.titleSelectedColor;
    
    self.selectedIndex = selectedLabel.tag;
    
    [self updateSelectedLabelPosition];
    
    if ([self.delegate_ respondsToSelector:@selector(pageScrollTitleViewDidSelected:selectedIndex:)]) {
        [self.delegate_ pageScrollTitleViewDidSelected:self selectedIndex:self.selectedIndex];
    }
}


#pragma mark - 懒加载
- (NSMutableArray<UILabel *> *)titleLabels {
    if (!_titleLabels) {
        _titleLabels = [NSMutableArray array];
    }
    return _titleLabels;
}
- (UIView *)bottomLine {
    if (!_bottomLine) {
        UILabel *firstLabel = self.titleLabels[0];
        CGFloat labelW = [firstLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, self.appreance.titleFont.capHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.appreance.titleFont} context:nil].size.width;
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(firstLabel.frame), CGRectGetMaxY(self.frame) - self.appreance.botomLineHeight, labelW, self.appreance.botomLineHeight)];
        _bottomLine.backgroundColor = self.appreance.bottomLineColor;
    }
    return _bottomLine;
}
@end
