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
        let layout = UICollectionViewFlowLayout()
        
        
        let pageCollectionView = YFPageCollectionView(frame: pageFrame, titles: titlesArr, isTitleInTop: true, layout: layout, style: style)
        view.addSubview(pageCollectionView)
        
        
        
    }



}

