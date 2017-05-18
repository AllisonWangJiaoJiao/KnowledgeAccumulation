//
//  YFPageStyle.swift
//  YFPageViewDemo
//
//  Created by Allison on 2017/4/27.
//  Copyright © 2017年 Allison. All rights reserved.
//

import UIKit

class YFPageStyle {
    
    var titleViewHeight : CGFloat = 44
    
    var normalColor : UIColor = UIColor(r: 0, g: 0, b: 0)
    var selectColor : UIColor = UIColor(r: 255, g: 127, b: 0)
    
    var fontSize : CGFloat = 15
    var titleFont : UIFont = UIFont.systemFont(ofSize: 15.0)

    //是否滚动
    var isScrollEnable : Bool = false
    //间距
    var itemMargin : CGFloat = 20
    
    
    var isShowBottomLine : Bool = true
    var bottomLineColor : UIColor = UIColor.orange
    var bottomLineHeight : CGFloat = 2

    
    
    
}
