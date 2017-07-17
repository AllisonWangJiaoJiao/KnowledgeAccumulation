//
//  AppDelegate.swift
//  TabbarDemo
//
//  Created by Allison on 2017/7/17.
//  Copyright © 2017年 Allison. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window?.rootViewController  = RootViewController.init(mainVC: BaseTabBarController())
        
        
        return true
    }

   
}

