//
//  YFPageCollectionView.swift
//  YFPageViewExtensionDemo
//
//  Created by Allison on 2017/5/21.
//  Copyright © 2017年 Allison. All rights reserved.
//

import UIKit

private let kCollectionViewCell = "kCollectionViewCell"

class YFPageCollectionView: UIView {
    
    fileprivate var titlesArr:[String]
    fileprivate var isTitleInTop: Bool
    fileprivate var layout: YFPageCollectionViewLayout
    fileprivate var style: YFPageStyle
    
    init(frame: CGRect,titles:[String],isTitleInTop :Bool,layout:YFPageCollectionViewLayout,style:YFPageStyle) {
        self.titlesArr = titles
        self.isTitleInTop = isTitleInTop
        self.layout = layout
        self.style = style
        
        super.init(frame: frame)
        
        setupUI()
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



}

extension YFPageCollectionView{
    fileprivate func setupUI(){
        //创建titleView
        let titleY = isTitleInTop ? 0 :bounds.height - style.titleHeight
        let titleFrame = CGRect(x: 0, y: titleY, width: bounds.width, height: style.titleHeight)
        let titleView = YFTitleView(frame: titleFrame, titles: titlesArr, style: style)
        addSubview(titleView)
        titleView.backgroundColor = UIColor.randomColor()
        
        //2.创建UIPageControl
        let pageControlHeight :CGFloat = 20
        
        let pageControlY = isTitleInTop ? (bounds.height - pageControlHeight) : (style.titleHeight)
        let pageControlFrame = CGRect(x: 0, y: pageControlY, width: bounds.width, height: pageControlHeight)
        let pageControl = UIPageControl(frame: pageControlFrame)
        pageControl.numberOfPages = 4
        addSubview(pageControl)
        pageControl.backgroundColor = UIColor.randomColor()
        
        //创建UICollectionView
        let collectionViewY = isTitleInTop ? style.titleHeight : 0
        let collectionViewFrame = CGRect(x: 0, y: collectionViewY, width: bounds.width, height: bounds.height - style.titleHeight - pageControlHeight)
        let collectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCollectionViewCell)
        addSubview(collectionView)
        collectionView.backgroundColor = UIColor.randomColor()
        
    }
}


extension YFPageCollectionView:UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(arc4random_uniform(30)) + 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionViewCell, for: indexPath)
        
        cell.backgroundColor = UIColor.randomColor()
        
        return cell
    }
    
}












