//
//  YLPageScrollView.swift
//  YLPageScrollView
//
//  Created by Youngly on 2017/3/12.
//  Copyright © 2017年 YL. All rights reserved.
//

import UIKit

class YLPageScrollView: UIView {

    var titles: [String]
    var childVCs : [UIViewController]
    var parentVC : UIViewController
    var appreance : YLPageScrollViewAppreance
    
    init(frame: CGRect, titles: [String], childVCs: [UIViewController], parentVC: UIViewController, appreance: YLPageScrollViewAppreance) {
        /// 初始化属性
        self.titles = titles
        self.childVCs = childVCs
        self.parentVC = parentVC
        self.appreance = appreance
        super.init(frame: frame)
        /// 设置子控件
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension YLPageScrollView {
    
    fileprivate func setupSubviews() {
        
        /// 添加YLPageScrollTitleView
        let titleViewFrame = CGRect(x: 0, y: 0, width: bounds.width, height: appreance.titleViewHeight)
        let titleView = YLPageScrollTitleView(frame: titleViewFrame, titles: titles, appreance: appreance)
        titleView.backgroundColor = UIColor.randomColor()
        addSubview(titleView)
        /// 添加YLPageScrollContentView
        let contentViewFrame = CGRect(x: 0, y: titleViewFrame.maxY, width: bounds.width, height: bounds.height - titleViewFrame.maxY)
        let contentView = YLPageScrollContentView(frame: contentViewFrame, childVCs: childVCs, parentVc: parentVC)
        contentView.backgroundColor = UIColor.randomColor()
        addSubview(contentView)
        
        titleView.delegate = contentView
        contentView.delegate = titleView
    }
}
