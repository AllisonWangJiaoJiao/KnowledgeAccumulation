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
            //
        }
        
    }


}

