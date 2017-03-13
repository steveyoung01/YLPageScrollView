//
//  YLPageScrollTitleView.m
//  YLPageScrollView
//
//  Created by Youngly on 2017/3/13.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "YLPageScrollTitleView.h"
#import "YLPageScrollViewConfigure.h"
#import "YLPageScrollViewAppreance.h"
#import "YLPageScrollContentView.h"

@interface YLPageScrollTitleView () <YLPageScrollContentViewDelegate>
@property (nonatomic, strong) NSArray<NSString *> *titles;
@property (nonatomic, strong) NSMutableArray<UILabel *> *titleLabels;
@property (nonatomic, strong) YLPageScrollViewAppreance *appreance;

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
        
        self.backgroundColor = [UIColor clearColor];
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
                X = i==0?appreance.titleOffset : appreance.titleOffset+CGRectGetMaxX(_titleLabels[i-1].frame);
            } else {
                W = YLPageScrollViewSW / titles.count;
                X = W * i;
            }
            titleLabel.frame = CGRectMake(X, Y, W, H);
            
            self.contentSize = CGSizeMake(CGRectGetMaxX([self.titleLabels lastObject].frame) + appreance.titleOffset, appreance.titleViewHeight);
        }
    }
    return self;
}

#pragma mark - YLPageScrollContentViewDelegate
- (void)pageScrollContentView:(YLPageScrollContentView *)contentView selectedIndex:(NSInteger)selectedIndex
{
    NSLog(@"%ld", selectedIndex);
}

#pragma mark - 监听titleLabel的点击
- (void)titleLabelClick:(UITapGestureRecognizer *)tap {
    UILabel *selectedLabel = (UILabel *)tap.view;
    if (selectedLabel == self.titleLabels[self.selectedIndex]) return;
    
    self.titleLabels[self.selectedIndex].textColor = self.appreance.titleNormalColor;
    selectedLabel.textColor = self.appreance.titleSelectedColor;
    
    self.selectedIndex = selectedLabel.tag;
    
    CGFloat offsetX = selectedLabel.center.x - self.frame.size.width * 0.5;
    if (offsetX <= 0) {
        offsetX = 0;
    }
    CGFloat maxOffsetX = self.contentSize.width - self.frame.size.width;
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
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
@end
