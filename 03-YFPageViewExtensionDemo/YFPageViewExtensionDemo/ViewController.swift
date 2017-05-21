//
//  ViewController.swift
//  YFPageViewExtensionDemo
//
//  Created by Allison on 2017/5/21.
//  Copyright © 2017年 Allison. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pageFrame = CGRect(x: 0, y: 100, width: view.bounds.width, height: 300)
        let titlesArr = ["土豪","热门","专属","礼物"]
        let style = YFPageStyle()
        style.isShowBottomLine = true
        let layout = YFPageCollectionViewLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumLineSpacing = 20
        layout.cols = 7
        layout.rows = 3
        let pageCollectionView = YFPageCollectionView(frame: pageFrame, titles: titlesArr, isTitleInTop: true, layout: layout, style: style)
        view.addSubview(pageCollectionView)
        
        
        
    }



}

