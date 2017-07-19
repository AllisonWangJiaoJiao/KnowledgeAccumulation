//
//  ViewController.swift
//  YFPageViewExtensionDemo
//
//  Created by Allison on 2017/5/21.
//  Copyright © 2017年 Allison. All rights reserved.
//

import UIKit

private let kEmoticonCell = "kEmoticonCell"

class ViewController: UIViewController {
    
    @IBAction func chatClick(_ sender: UIButton) {
        
        let roomVc = RoomViewController()
        navigationController?.pushViewController(roomVc, animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let pageFrame = CGRect(x: 0, y: 100, width: view.bounds.width, height: 300)
//        let titlesArr = ["土豪","热门","专属","礼物"]
//        let style = YFPageStyle()
//        style.isShowBottomLine = true
//        let layout = YFPageCollectionViewLayout()
//        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 0)
//        layout.minimumLineSpacing = 0
//        layout.minimumLineSpacing = 0
////        layout.cols = 7
////        layout.rows = 3
//        let pageCollectionView = YFPageCollectionView(frame: pageFrame, titles: titlesArr, isTitleInTop: false, layout: layout, style: style)
//        pageCollectionView.dataSource = self
//        pageCollectionView.register(cell: UICollectionViewCell.self, identifier: kEmoticonCell)
//
//        view.addSubview(pageCollectionView)
    }
}

extension ViewController : YFPageCollectionViewDataSource{
    
    func numberOfSections(in pageCollectionView: YFPageCollectionView) -> Int {
        return 4
    }
    
    func pageCollectionView(_ collectionView: YFPageCollectionView, numberOfItemsInSection section: Int) -> Int {
//        return Int(arc4random_uniform(30)) + 25
        if section == 0 {
            return 20
        }else {
            return 14
        }
        
    }
    
    func pageCollectionView(_ pageCollectionView: YFPageCollectionView, _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kEmoticonCell, for: indexPath)
        
        cell.backgroundColor = UIColor.randomColor()
        
        return cell
    }
}
