//
//  YFContentView.swift
//  YFPageViewDemo
//
//  Created by Allison on 2017/4/27.
//  Copyright © 2017年 Allison. All rights reserved.
//

import UIKit

/**
 self.不能省略的情况
    1> 在方法中和其它的标识符有歧义(重名)
    2> 在闭包中self.也不能省略
 */

//保存所有的自控制器

private let kContentCellID = "kContentCellID"

protocol YFContentViewDelegate:class {
    func contentView(_ contentView : YFContentView, targetIndex: Int)
    func contentView(_ contentView : YFContentView, targetIndex : Int, progress : CGFloat)

}


class YFContentView: UIView {
    
    weak var  delegate : YFContentViewDelegate?
    
    fileprivate lazy var isForbidDelegate : Bool = false
    fileprivate var startOffsetX :CGFloat = 0 //记录开始拖拽的值
    fileprivate var childVcsArr : [UIViewController]
    fileprivate var parentVc : UIViewController
    fileprivate lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal//滚动的方向
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kContentCellID)
        collectionView.isPagingEnabled = true
        collectionView.scrollsToTop = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        
        return collectionView
    }()

    // MARK: 构造函数
    init(frame : CGRect, childVcs : [UIViewController], parentVc : UIViewController) {
        
        self.childVcsArr = childVcs
        self.parentVc = parentVc
        super.init(frame: frame)
        
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.scrollsToTop = false
        
        setupUI()
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension YFContentView {
    fileprivate func setupUI(){
        
        // 1.将childVc添加到父控制器中
        for vc in childVcsArr {
            parentVc.addChildViewController(vc)
        }
        // 2.初始化用于显示子控制器View的View（UIScrollView/UICollectionView）
        addSubview(collectionView)
        
    }
}

// MARK:- 遵守UICollectionViewDataSource协议
extension YFContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcsArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kContentCellID, for: indexPath)
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        //把控制器都加到Item里面.
        let vc = childVcsArr[indexPath.item]
        vc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(vc.view)

        return cell
    }
}


// MARK:- 遵守UICollectionViewDelegate协议
extension YFContentView : UICollectionViewDelegate {
    //目标:滚动停止 标签的选中状态改变
    //1.停止减速
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        contentEndScroll()
    }
    //2.没有减速
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        contentEndScroll()
    }
    
    
     private func contentEndScroll() {
        //获取滚动到的位置
        let currentIndex = Int(collectionView.contentOffset.x / collectionView.bounds.width)
        //通知titleView进行调整
        delegate?.contentView(self, targetIndex: currentIndex)
        
    }
    
    //开始拖拽
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // 记录开始的位置
        isForbidDelegate = false
        startOffsetX = scrollView.contentOffset.x
        
    }
    
    //实时监控滚动
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //0.判断和我开始时的偏移量是否一致
       if scrollView.contentOffset.x == startOffsetX || isForbidDelegate { return }
        
        // 1.定义目标的index、进度
        var targetIndex : Int = 0
        var progress : CGFloat = 0
        
        // 2.判断用户是左滑还是右滑
        if scrollView.contentOffset.x > startOffsetX { // 左滑
            targetIndex = Int(startOffsetX / scrollView.bounds.width) + 1
            if targetIndex >= childVcsArr.count {
                targetIndex = childVcsArr.count - 1
            }
            progress = (scrollView.contentOffset.x - startOffsetX) / scrollView.bounds.width
        } else { // 右滑
            targetIndex = Int(startOffsetX / scrollView.bounds.width) - 1
            if targetIndex < 0 {
                targetIndex = 0
            }
            progress = (startOffsetX - scrollView.contentOffset.x) / scrollView.bounds.width
        }
        
        //3.通知代理
        delegate?.contentView(self, targetIndex: targetIndex, progress: progress)        
        
    }
}

//MARK:-遵守titleViewDelegate  点击标签,切换下面的contentView
extension YFContentView :YFTitleViewDelegate{
    func titleView(_ titleView: YFTitleView, targetIndex: Int) {
         isForbidDelegate = true
        let indexPath = IndexPath(item: targetIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
        
    }
}







