//
//  YLPageScrollTitleView.swift
//  YLPageScrollView
//
//  Created by Youngly on 2017/3/12.
//  Copyright © 2017年 YL. All rights reserved.
//

import UIKit

protocol YLPageScrollTitleViewDelegate : class {
    func titleView(titleView: YLPageScrollTitleView, lastIndex: Int, selectedIndex: Int)
}

class YLPageScrollTitleView: UIView {
    // MARK: 属性列表
    weak var delegate : YLPageScrollTitleViewDelegate?
    var titles : [String]
    var appreance : YLPageScrollViewAppreance
    var selectedIndex : Int = 0
    lazy var normalRGB : (CGFloat, CGFloat, CGFloat) = self.appreance.titleNormalColor.getRGBValue()
    lazy var selectRGB : (CGFloat, CGFloat, CGFloat) = self.appreance.titleSelectedColor.getRGBValue()
    lazy var deltaRGB : (CGFloat, CGFloat, CGFloat) = {
        let deltaR = self.selectRGB.0 - self.normalRGB.0
        let deltaG = self.selectRGB.1 - self.normalRGB.1
        let deltaB = self.selectRGB.2 - self.normalRGB.2
        return (deltaR, deltaG, deltaB)
    }()
    
    lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView(frame: self.bounds)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        return scrollView
    }()
    lazy var titleLabels : [UILabel] = [UILabel]()
    lazy var bottomLine : UIView = {
        let bottomLine = UIView()
        bottomLine.backgroundColor = self.appreance.bottomLineColor
        return bottomLine
    }()
    // MARK: 初始化
    init(frame: CGRect, titles: [String], appreance: YLPageScrollViewAppreance) {
        
        self.titles = titles
        self.appreance = appreance
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 设置子视图
extension YLPageScrollTitleView {
    fileprivate func setupSubviews() {
        
        addSubview(scrollView)
       
        setupTitleLabels()
        
        if appreance.isShowBottomLine {
            setupBottomLine()
        }
        
        if appreance.isNeedScale {
            setupTitleLabelScale()
        }
    }
    
    // MARK: 设置所有的 label
    private func setupTitleLabels() {
        // MARK: 初始化
        for (i, title) in titles.enumerated() {
            let label = UILabel()
            titleLabels.append(label)
            label.textAlignment = .center
            label.font = appreance.titleFont
            label.textColor = appreance.titleNormalColor
            label.backgroundColor = UIColor.randomColor()
            label.isUserInteractionEnabled = true
            label.text = title
            label.tag = i
            let tap = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(_:)))
            label.addGestureRecognizer(tap)
            scrollView.addSubview(label)
        }
        // MARK: 设置 frame
        var X : CGFloat = 0
        let Y : CGFloat = 0
        var W : CGFloat = bounds.width / CGFloat(titles.count)
        let H : CGFloat = appreance.titleViewHeight
        for (i, titlLabel) in titleLabels.enumerated() {
            if appreance.isScrollEnable { // 允许滚动
                W = (titlLabel.text! as NSString).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: 0), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName : appreance.titleFont], context: nil).width
                X = titlLabel.tag==0 ? appreance.titleOffset : (titleLabels[i-1].frame.maxX+appreance.titleMargin)
            } else { // 禁止滚动
                X = W * CGFloat(i)
            }
            titlLabel.frame = CGRect(x: X, y: Y, width: W, height: H)
        }
        // MARK: 设置contentSize
        if appreance.isScrollEnable {
            scrollView.contentSize = CGSize(width: titleLabels.last!.frame.maxX+appreance.titleOffset, height: appreance.titleViewHeight)
        }
    }
    // MARK: 设置底部指示线
    private func setupBottomLine() {
        scrollView.addSubview(bottomLine)
        bottomLine.frame = titleLabels.first!.frame
        bottomLine.frame.size.height = appreance.botomLineHeight
        bottomLine.frame.origin.y = bounds.height - bottomLine.frame.height
    }
    // MARK: 设置形变
    private func setupTitleLabelScale() {
        titleLabels.first?.transform = CGAffineTransform(scaleX: appreance.maxScaleRatio, y: appreance.maxScaleRatio)
    }
}

// MARK: - 监听 label 的点击
extension YLPageScrollTitleView {
    
    @objc fileprivate func titleLabelClick(_ tap : UITapGestureRecognizer) {
        
        guard let selectedLabel = tap.view as? UILabel else {
            return
        }
        guard selectedLabel.tag != selectedIndex else {
            return
        }
        
        let sourceLabel = titleLabels[selectedIndex]
        selectedLabel.textColor = appreance.titleSelectedColor
        sourceLabel.textColor = appreance.titleNormalColor
        
        delegate?.titleView(titleView: self, lastIndex: selectedIndex, selectedIndex: selectedLabel.tag)
        selectedIndex = selectedLabel.tag
        updateSelectedLabelPosition()
        
        if appreance.isNeedScale {
            UIView.animate(withDuration: 0.25, animations: {
                sourceLabel.transform = CGAffineTransform.identity
                selectedLabel.transform = CGAffineTransform(scaleX: self.appreance.maxScaleRatio, y: self.appreance.maxScaleRatio)
            })
        }
        
        if appreance.isShowBottomLine {
            UIView.animate(withDuration: 0.25, animations: {
                self.bottomLine.frame.origin.x = selectedLabel.frame.origin.x
                self.bottomLine.frame.size.width = selectedLabel.frame.width
            })
        }
    }
    
    fileprivate func updateSelectedLabelPosition() {
        guard appreance.isScrollEnable else { return }
        
        let selectedLabel = titleLabels[selectedIndex]
        var offsetX = selectedLabel.center.x - scrollView.bounds.width * 0.5
        if offsetX < 0 {
            offsetX = 0
        }
        let maxOffsetX = scrollView.contentSize.width - scrollView.bounds.width
        if offsetX > maxOffsetX {
            offsetX = maxOffsetX
        }
        scrollView.setContentOffset(CGPoint(x: offsetX, y:0), animated: true)
    }
}


extension YLPageScrollTitleView : YLPageScrollContentViewDelegate {
    func contentView(_ contentView: YLPageScrollContentView, didEndScroll inIndex: Int) {
        selectedIndex = inIndex
        updateSelectedLabelPosition()
    }
    
    func contentView(_ contentView: YLPageScrollContentView, sourceIndex: Int, targetIndex: Int, progress: CGFloat) {
        
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        sourceLabel.textColor = UIColor(r: selectRGB.0 - deltaRGB.0 * progress, g: selectRGB.1 - deltaRGB.1 * progress, b: selectRGB.2 - deltaRGB.2 * progress)
        targetLabel.textColor = UIColor(r: normalRGB.0 + deltaRGB.0 * progress, g: normalRGB.1 + deltaRGB.1 * progress, b: normalRGB.2 + deltaRGB.2 * progress)
        
        // 缩放的变化
        if appreance.isNeedScale {
            let deltaScale = appreance.maxScaleRatio - 1.0
            sourceLabel.transform = CGAffineTransform(scaleX: appreance.maxScaleRatio - deltaScale * progress, y: appreance.maxScaleRatio - deltaScale * progress)
            targetLabel.transform = CGAffineTransform(scaleX: 1.0 + deltaScale * progress, y: 1.0 + deltaScale * progress)
        }
        
        // 计算bottomLine的width/x变化
        let deltaWidth = targetLabel.frame.width - sourceLabel.frame.width
        let deltaX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        if appreance.isShowBottomLine {
            bottomLine.frame.size.width = deltaWidth * progress + sourceLabel.frame.width
            bottomLine.frame.origin.x = deltaX * progress + sourceLabel.frame.origin.x
        }
    }
}
