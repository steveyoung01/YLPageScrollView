//
//  ViewController.swift
//  YLPageScrollView
//
//  Created by Youngly on 2017/3/13.
//  Copyright © 2017年 YL. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        
        /// 设置数据源
//        let titles = ["推荐", "移动互联网", "科技", "数码"]
        let titles = ["推荐", "移动互联网", "人民日报社", " iOS", "Java", "百代旅行事业部", "国家人文历史"]
        var childVCs = [UIViewController]()
        for _ in 0..<titles.count {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.randomColor()
            childVCs.append(vc)
        }
        
        /// 设置外观
        let appreance = YLPageScrollViewAppreance()
        appreance.titleNormalColor = UIColor.white
        appreance.titleSelectedColor = UIColor.orange
        appreance.isScrollEnable = true
        appreance.isShowBottomLine = true
        appreance.bottomLineColor = UIColor.red
        
        /// 设置frame并添加到父视图
        let frame = CGRect(x: 0, y: 64, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64)
        let pageScrollView = YLPageScrollView(frame: frame, titles: titles, childVCs: childVCs, parentVC: self, appreance: appreance)
        view.addSubview(pageScrollView)
    }
}


// MARK: - 获取随机色
extension UIColor {
    
    class func randomColor() -> UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(256))/255.0, green: CGFloat(arc4random_uniform(256))/255.0, blue: CGFloat(arc4random_uniform(256))/255.0, alpha: 1.0)
    }
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
}
// MARK:- 从颜色中获取RGB的值
extension UIColor {
    func getRGBValue() -> (CGFloat, CGFloat, CGFloat) {
        
        var red : CGFloat = 0
        var green : CGFloat = 0
        var blue : CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: nil)
        
        return (red * 255, green * 255, blue * 255)
    }
}
