//
//  AppDelegate.swift
//  AlipayDemo
//
//  Created by Allison on 2017/5/5.
//  Copyright © 2017年 Allison. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
       
        let urlStr = url.absoluteString
        print(urlStr.removingPercentEncoding)
        
        return true
    }
}

