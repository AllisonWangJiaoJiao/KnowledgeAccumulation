//
//  ViewController.swift
//  UmengShareDemo
//
//  Created by Allison on 2017/5/4.
//  Copyright © 2017年 Allison. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func shareWebClick(_ sender: UIButton) {
       // shareActionWeb()
        umengLoginAction()
    }
    
    func umengLoginAction() -> () {
        //创建一个平台对象,代表第三方登录的平台
        UMSocialManager.default().getUserInfo(with: UMSocialPlatformType.sina, currentViewController: self) { (result, error) in
            let resp  = result as! UMSocialUserInfoResponse
            //授权数据
             print("uid: \(resp.uid)")
             print("openid: \(resp.openid)")
             print("refreshToken: \(resp.refreshToken)")
             print("expiration: \(resp.expiration)")
            //用户数据
            print("name: \(resp.name)")
            print("iconurl: \(resp.iconurl)")
            print("gender: \(resp.gender)")
            
            //第三方平台SDK原始数据
            print("originalResponse: \(resp.originalResponse)")
            
        }
        
    }
    
    
    func shareActionWeb(){
        UMSocialUIManager.showShareMenuViewInWindow { (platformType, userInfo) in
            print(platformType,userInfo)
            
            let messageObject : UMSocialMessageObject = UMSocialMessageObject.init()
            messageObject.text = "新浪微博测试网站"
            
            //分享网页
            let shareObject : UMShareWebpageObject = UMShareWebpageObject.init()
            shareObject.title = "网站"
            shareObject.descr = "测试测试网站"
            shareObject.thumbImage = UIImage.init(named: "tab_live")
            shareObject.webpageUrl = "http://www.baidu.com"
            messageObject.shareObject = shareObject
            
            UMSocialManager.default().share(to: platformType, messageObject: messageObject, currentViewController: self, completion: { (shareResponse, error) in
                print(shareObject,error)
            })
            
        }
        
    }
    
}



