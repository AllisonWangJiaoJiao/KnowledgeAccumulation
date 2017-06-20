//
//  BaseView.swift
//  QRCodeDemo
//
//  Created by Allison on 2017/6/20.
//  Copyright © 2017年 Allison. All rights reserved.
//

import UIKit

//@IBDesignable告诉编译器，此类可以被nib识别使用
@IBDesignable class BaseView: UIView {

    @IBInspectable var borderWidth : CGFloat = 0{
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor : UIColor = UIColor.clear{
        didSet{
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var cornerRadius : CGFloat = 0{
        didSet{
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var masksToBounds : Bool = false{
        didSet{
            layer.masksToBounds = masksToBounds
        }
    }



}
