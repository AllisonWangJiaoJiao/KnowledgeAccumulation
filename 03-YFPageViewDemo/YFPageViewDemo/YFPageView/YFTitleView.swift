//
//  YFTitleView.swift
//  YFPageViewDemo
//
//  Created by Allison on 2017/4/27.
//  Copyright © 2017年 Allison. All rights reserved.
//

import UIKit

class YFTitleView: UIView {
    fileprivate var titles : [String]
    fileprivate var style : YFPageStyle

    init(frame: CGRect,titles:[String],style:YFPageStyle) {
        self.titles = titles
        self.style = style
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension YFTitleView {
    fileprivate func setupUI() {
        
        
    }
}
