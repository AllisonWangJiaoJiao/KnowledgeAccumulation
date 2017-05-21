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

}

extension YFPageCollectionViewLayout {
    //1.准备布局
    override func prepare() {
        super.prepare()
    }
}

extension YFPageCollectionViewLayout {
    //2.返回准备好的布局
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        <#code#>
    }
}

extension YFPageCollectionViewLayout {
    //3.返回滚动区域
    override var collectionViewContentSize: CGSize{
        return CGSize.zero
    }
}
