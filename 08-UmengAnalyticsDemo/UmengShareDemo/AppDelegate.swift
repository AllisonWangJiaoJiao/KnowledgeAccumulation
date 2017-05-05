//
//  AppDelegate.swift
//  UmengShareDemo
//
//  Created by Allison on 2017/5/4.
//  Copyright © 2017年 Allison. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //友盟统计
        UMAnalyticsConfig.sharedInstance().appKey = "590acfc9cae7e73ae4000364"
        UMAnalyticsConfig.sharedInstance().channelId = "App Store"
        MobClick.start(withConfigure: UMAnalyticsConfig.sharedInstance())
        //友盟基础skd授权
        UMSocialManager.default().umSocialAppkey = "590acfc9cae7e73ae4000364"
        
        //开启调试日志
        MobClick.setLogEnabled(true)
        
        
        configUSharePlatforms()
        
        return true
    }
    func configUSharePlatforms() -> () {
        
         /* 设置新浪微博的appKey和appSecret */
        UMSocialManager.default().setPlaform(UMSocialPlatformType.sina, appKey: "2690150259", appSecret: "c643e38611549d188cd6b62f7f3cc686", redirectURL: "http://weibo.com")
        
        /* 设置微信的appKey和appSecret */
         UMSocialManager.default().setPlaform(UMSocialPlatformType.wechatSession, appKey: "wxdc1e388c3822c80b", appSecret: "3baf1193c85774b3fd9d18447d76cab0", redirectURL: "http://mobile.umeng.com/social")

        /* 设置分享到QQ互联的appID
         * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
         */
        UMSocialManager.default().setPlaform(UMSocialPlatformType.QQ, appKey: "1105821097", appSecret: nil, redirectURL: "http://mobile.umeng.com/social")
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        let result = UMSocialManager.default().handleOpen(url)
        print(result)
        if !result{
            
        }
        return result
    }
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        let result = UMSocialManager.default().handleOpen(url)
        if !result{
            
        }
        return result
    }


    

}

