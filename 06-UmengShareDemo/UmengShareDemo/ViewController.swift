//
//  ViewController.swift
//  UmengShareDemo
//
//  Created by Allison on 2017/5/4.
//  Copyright © 2017年 Allison. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        UMSocialUIManager.showShareMenuViewInWindow { (platformType, userInfo) in
            print(platformType,userInfo)
        }
        UMSocialUIManager.setShareMenuViewDelegate(self)
        
        
    }
    
}

extension ViewController :UMSocialShareMenuViewDelegate{
    //不需要改变父窗口则不需要重写此协议
    func umSocialParentView(_ defaultSuperView: UIView!) -> UIView! {
        return defaultSuperView
    }
}
