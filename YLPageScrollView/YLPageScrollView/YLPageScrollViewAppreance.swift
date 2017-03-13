//
//  YLPageScrollViewAppreance.swift
//  YLPageScrollView
//
//  Created by Youngly on 2017/3/12.
//  Copyright © 2017年 YL. All rights reserved.
//

import UIKit

class YLPageScrollViewAppreance {

    /// 标题文字大小
    var titleFont : UIFont = UIFont.systemFont(ofSize: 14)
    /// 标题滚动视图的高度
    var titleViewHeight : CGFloat = 40.0
    /// 标题左右距离屏幕的偏移量
    var titleOffset : CGFloat = 8
    /// 标题文字之间的间距
    var titleMargin : CGFloat = 20
    /// 底部线的高度
    var botomLineHeight : CGFloat = 3.0
    /// 文字缩放系数
    var maxScaleRatio : CGFloat = 1.2
    
    /// 标题文字普通颜色
    var titleNormalColor : UIColor = UIColor(r: 200, g: 200, b: 200)
    /// 标题文字选中颜色
    var titleSelectedColor : UIColor = UIColor(r: 50, g: 50, b: 50)
    /// 标题底部线的颜色, 默认=titleNormalColor
    lazy var bottomLineColor : UIColor = {
        let bottomLineColor = self.titleNormalColor
        return bottomLineColor
    }()
    
    /// 是否允许标题栏滚动
    var isScrollEnable : Bool = false
    /// 是否显示底部线
    var isShowBottomLine = false
    /// 是否需要缩放标题
    var isNeedScale = true
}
