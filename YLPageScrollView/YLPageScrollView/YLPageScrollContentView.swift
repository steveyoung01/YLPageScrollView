//
//  YLPageScrollContentView.swift
//  YLPageScrollView
//
//  Created by Youngly on 2017/3/12.
//  Copyright © 2017年 YL. All rights reserved.
//

import UIKit

private let cellId = "cellId"

protocol YLPageScrollContentViewDelegate : class {
    func contentView(_ contentView : YLPageScrollContentView, didEndScroll inIndex : Int)
    func contentView(_ contentView : YLPageScrollContentView, sourceIndex : Int, targetIndex : Int, progress : CGFloat)
}

class YLPageScrollContentView: UIView {

    weak var delegate : YLPageScrollContentViewDelegate?
    
    fileprivate var startOffsetX : CGFloat = 0
    fileprivate var childVCs : [UIViewController]
    fileprivate var parentVc : UIViewController
    fileprivate var isForbidDelegate : Bool = false
    fileprivate lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.scrollsToTop = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        return collectionView
    }()
    
    init(frame: CGRect, childVCs: [UIViewController], parentVc:UIViewController) {
        
        self.childVCs = childVCs
        self.parentVc = parentVc
        
        super.init(frame: frame)
        backgroundColor = UIColor.randomColor()
        
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension YLPageScrollContentView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        cell.contentView.addSubview(childVCs[indexPath.row].view)
        
        return cell
    }
}

extension YLPageScrollContentView : UICollectionViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEndScroll()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollViewDidEndScroll()
        }
    }
    
    private func scrollViewDidEndScroll() {
        let index = Int(collectionView.contentOffset.x / collectionView.bounds.width)
        delegate?.contentView(self, didEndScroll: index)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetX = scrollView.contentOffset.x
        guard contentOffsetX != startOffsetX && !isForbidDelegate else {
            return
        }
        
        var sourceIndex = 0
        var targetIndex = 0
        var progress : CGFloat = 0
        
        let collectionWidth = collectionView.bounds.width
        if contentOffsetX > startOffsetX { // 左滑动
            sourceIndex = Int(contentOffsetX / collectionWidth)
            targetIndex = sourceIndex + 1
            if targetIndex >= childVCs.count {
                targetIndex = childVCs.count - 1
            }
            progress = (contentOffsetX - startOffsetX) / collectionWidth
            if (contentOffsetX - startOffsetX) == collectionWidth {
                targetIndex = sourceIndex
            }
            
        } else { // 右滑动
            targetIndex = Int(contentOffsetX / collectionWidth)
            sourceIndex = targetIndex + 1
            progress = (startOffsetX - contentOffsetX) / collectionWidth
        }
        
        delegate?.contentView(self, sourceIndex: sourceIndex, targetIndex: targetIndex, progress: progress)
    }
}

// MARK: - YLPageScrollContentView
extension YLPageScrollContentView {
    fileprivate func setupSubviews() {
        for childVC in childVCs {
            parentVc.addChildViewController(childVC)
        }
        addSubview(collectionView)
    }
}

// MARK:- 遵守YLPageScrollTitleViewDelegate
extension YLPageScrollContentView : YLPageScrollTitleViewDelegate {
    func titleView(titleView: YLPageScrollTitleView, lastIndex: Int, selectedIndex: Int) {
        isForbidDelegate = true
        let indexPath = IndexPath(item: selectedIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
    }
}
