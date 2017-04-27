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

    init(frame: CGRect,titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
