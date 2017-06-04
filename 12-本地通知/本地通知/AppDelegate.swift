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
            //请求的权限
            let type = UIUserNotificationType.alert.rawValue | UIUserNotificationType.badge.rawValue | UIUserNotificationType.badge.rawValue
            //1.创建异族操作行为
            let category : UIMutableUserNotificationCategory = UIMutableUserNotificationCategory()
            //1.1设置组标志
            category.identifier = "selected"
            //1.2设置组里面的操作行为
            let action1 = UIMutableUserNotificationAction()
            //1.2.1设置操作行为的参数
            action1.identifier = "网站"
            action1.title = "手机"
            //代表 用户在前台还是后台点击了这个动作
            action1.activationMode = .foreground
            //必须解锁之后,才会执行(如果是前台状态 那这个属性就会被忽略)
            action1.isAuthenticationRequired = true
            //是否是破坏性行为(使用一个红色的标志来标识这个按钮)
            action1.isDestructive = true
            
            
            //1.2设置组里面的操作行为
            let action2 = UIMutableUserNotificationAction()
            //1.2.2设置操作行为的参数
            action2.identifier = "网站22"
            action2.title = "手机22"
            //代表 用户在前台还是后台点击了这个动作
            action2.activationMode = .foreground
            //必须解锁之后,才会执行(如果是前台状态 那这个属性就会被忽略)
            action2.isAuthenticationRequired = true
            //是否是破坏性行为(使用一个红色的标志来标识这个按钮)
            action2.isDestructive = true
            
            
            let actions : [UIUserNotificationAction] = [action1,action2]
            category.setActions(actions, for: UIUserNotificationActionContext.default)
            
            
            //附件操作行为
            let categories: Set<UIUserNotificationCategory> = [category]
            //设置对象
            let sets = UIUserNotificationSettings(types: UIUserNotificationType(rawValue: type), categories: categories)
            UIApplication.shared.registerUserNotificationSettings(sets)
        }
    }
}

