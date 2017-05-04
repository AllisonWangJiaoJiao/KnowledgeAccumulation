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
        
       shareAction_pic()
        
    }
    func shareAction_pic (){
        UMSocialUIManager.showShareMenuViewInWindow { (platformType, userInfo) in
            print(platformType,userInfo)
            
            let messageObject : UMSocialMessageObject = UMSocialMessageObject.init()
            messageObject.text = "新浪微博测试网站"
            
            //分享网页
            let shareObject : UMShareWebpageObject = UMShareWebpageObject.init()
            shareObject.title = "网站"
            shareObject.descr = "测试测试网站"
            shareObject.thumbImage = UIImage.init(named: "icon_circle")
            shareObject.webpageUrl = "http://www.baidu.com"
            messageObject.shareObject = shareObject
            
            UMSocialManager.default().share(to: platformType, messageObject: messageObject, currentViewController: self, completion: { (shareResponse, error) in
                print(shareObject,error)
            })
            
        }
        
    }
    
}


