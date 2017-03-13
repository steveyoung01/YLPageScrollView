//
//  ViewController.m
//  YLPageScrollView_Objective-C
//
//  Created by Youngly on 2017/3/13.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "ViewController.h"
#import "YLPageScrollView.h"
#import "YLPageScrollViewConfigure.h"
#import "YLPageScrollViewAppreance.h"

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *childVCs;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGRect frame = CGRectMake(0, 64, YLPageScrollViewSW, YLPageScrollViewSH - 64);
    NSArray *titles = @[@"推荐", @"移动互联网", @"人民日报社", @"iOS", @"Java", @"百代旅行事业部", @"国家人文历史"];
    for (NSInteger i=0; i<titles.count; i++) {
        UIViewController *tempVC = [UIViewController new];
        tempVC.view.backgroundColor = YLPageScrollViewRandomColor;
        [self.childVCs addObject:tempVC];
    }
    YLPageScrollViewAppreance *appreance = [YLPageScrollViewAppreance new];
    
    YLPageScrollView *pageScrollView = [YLPageScrollView pageScrollView:frame titles:titles childVCs:self.childVCs parentVC:self appreance:appreance];
    [self.view addSubview:pageScrollView];
}

- (NSMutableArray *)childVCs {
    if (!_childVCs) {
        _childVCs = [NSMutableArray array];
    }
    return _childVCs;
}
@end
