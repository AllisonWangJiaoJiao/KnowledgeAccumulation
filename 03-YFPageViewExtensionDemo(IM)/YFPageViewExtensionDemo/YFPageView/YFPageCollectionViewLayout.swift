//
//  YFPageCollectionViewLayout.swift
//  YFPageViewExtensionDemo
//
//  Created by Allison on 2017/5/21.
//  Copyright © 2017年 Allison. All rights reserved.
//


///自定义流水布局的三个步骤
import UIKit

class YFPageCollectionViewLayout: UICollectionViewFlowLayout {
    fileprivate lazy var celllAttrsArr :[UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    var cols : Int = 4 //列数
    var rows : Int = 2 //行数
    fileprivate lazy var maxWidth : CGFloat = 0


}

extension YFPageCollectionViewLayout {
    //1.准备布局
    override func prepare() {
        super.prepare()
        
        //0.计算item的宽度&高度
        let itemW = (collectionView!.bounds.width - sectionInset.left - sectionInset.right - minimumInteritemSpacing * CGFloat(cols - 1)) / CGFloat(cols)
        let itemH = (collectionView!.bounds.height - sectionInset.top - sectionInset.bottom - minimumLineSpacing * CGFloat(rows - 1)) / CGFloat(rows)
        

        //1.获取一共有多少组
          let sectionCount = collectionView!.numberOfSections
        
        //2.获取每组有多少个Item
        var prePageCount : Int = 0
        
        for i in 0..<sectionCount {
            let itemCount = collectionView!.numberOfItems(inSection: i)
            for j in 0..<itemCount {
                ///2.1获取cell对应的indexPath
                let indexPath = IndexPath(item: j, section: i)
                
                //2.2根据indexPath 创建UICollectionViewLayoutAttributes
                let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                
                //2.3.1 计算j在在改组中第几列
                let page = j / (cols * rows)
                //2.3.2 在该页的第几个
                let index = j % (cols * rows)
                
                //2.3 设置attr的frame
                let itemY = sectionInset.top + (itemH + minimumLineSpacing) * CGFloat(index / cols)
                let itemX = CGFloat(prePageCount + page) * collectionView!.bounds.width + sectionInset.left + (itemW + minimumInteritemSpacing) * CGFloat(index % cols)
                attr.frame = CGRect(x: itemX, y: itemY, width: itemW, height: itemH)
                
                
                //2.4保存attr到数组中
                celllAttrsArr.append(attr)
                
            }
            //2.5计算一共有几页
            prePageCount += (itemCount - 1)/(cols * rows) + 1
        }
        //3.计算最大Y值
         maxWidth = CGFloat(prePageCount) * collectionView!.bounds.width
        
    }
}

extension YFPageCollectionViewLayout {
    //2.返回准备好的布局
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return celllAttrsArr
    }
}

extension YFPageCollectionViewLayout {
    //3.返回滚动区域
    override var collectionViewContentSize: CGSize{
        return CGSize(width: maxWidth, height: 0)
    }
}
