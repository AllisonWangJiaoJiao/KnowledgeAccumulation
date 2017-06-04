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
        
        
        registerAuthor()
        
        return true
    }
    //即将进入前台
    func applicationDidBecomeActive(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
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

