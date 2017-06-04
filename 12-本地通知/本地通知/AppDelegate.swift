//
//  AppDelegate.swift
//  本地通知
//
//  Created by Allison on 2017/6/4.
//  Copyright © 2017年 Allison. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //launchOptions:如果APP不是通过正常启动(点击应用程序的图标启动),都会把应用程序的一些信息参数,放到这个字典里
        print(launchOptions)
        let tv = UITextView(frame: CGRect(x: 0, y: 20, width: 300, height: 200))
        tv.backgroundColor = UIColor.cyan
        tv.text = launchOptions?.description
        window?.rootViewController?.view.addSubview(tv)
        
        if launchOptions != nil {
            let local = launchOptions![UIApplicationLaunchOptionsKey.localNotification]
            //说明 如果是点击了本地通知,启动的APP
            if local != nil {
                //以后实际开发中 会在这个位置,做一些用户点击了本地通知之后的一些业务逻辑处理
            }

        }
        
        
        registerAuthor()
        
        return true
    }
    //即将进入前台
    func applicationDidBecomeActive(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    //当接受到通知 并且满足以下条件时 就会调用
    //1.前台
    //2.从后台进入到前台(用户点击了通知,启动了app)
    //3.锁屏(从后台进入到前台)
    //4.完全关闭(判断:如果是app完全退出 应用程序收到通知后,不会调用这个方法!!!)
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        print("接受到通知")
        print(UIApplication.shared.applicationState.rawValue)
        //case active 前台
        //case inactive 从后台进入到前台
        //case background
        
        let state = UIApplication.shared.applicationState
        if state == .active {
            //前台
        }
        if state == .inactive {
            // 后台
        }
        
        
    }

    
    //注册通知授权
    func registerAuthor()  {
        
        if #available(iOS 8.0, *) {
            let type = UIUserNotificationType.alert.rawValue | UIUserNotificationType.badge.rawValue | UIUserNotificationType.badge.rawValue
            let sets = UIUserNotificationSettings(types: UIUserNotificationType(rawValue: type), categories: nil)
            UIApplication.shared.registerUserNotificationSettings(sets)
        }
    }
}

