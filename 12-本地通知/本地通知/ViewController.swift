//
//  ViewController.swift
//  本地通知
//
//  Created by Allison on 2017/6/4.
//  Copyright © 2017年 Allison. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    //发送通知
    //iOS8.0以后,需要主动请求授权,才可以发送通知
    
    //通知显示的条件 必须不能在前台
    @IBAction func sendNotificationClick(_ sender: UIButton) {
        
        //1.创建一个本地通知
        let localNot = UILocalNotification()
        //1.1设置通知的必选项
        localNot.alertBody = "顺子要不要"
        //1.2通知的发送时间
        localNot.fireDate = NSDate(timeIntervalSinceNow: 2) as Date

        //重复周期
        //localNot.repeatInterval = .minute
        //设置锁屏滑动文字
        localNot.alertAction  = "回复"
        //启动图片(iOS9.0有个小bug  不太灵)
        localNot.alertLaunchImage =  "daohang_icon"
        //设置通知弹框的标题
        //标题,只对于通知中心的通知有效
        if #available(iOS 8.2, *) {
            localNot.alertTitle = "斗地主"
        } else {
            // Fallback on earlier versions
        }
        //设置通知的声音
        localNot.soundName = ""
        //设置图标右上角的数字(0代表不显示)
        localNot.applicationIconBadgeNumber = 10
      
        
        //2.发送本地通知
        //应用程序界别的操作
        UIApplication.shared.scheduleLocalNotification(localNot)
        //UIApplication.shared.presentLocalNotificationNow(localNot)
        
    }
   
    //取消通知
    @IBAction func cancleNotificationClick(_ sender: UIButton) {
        
        //取消所有计划的通知
        UIApplication.shared.cancelAllLocalNotifications()
        
    }
    
    //查看通知
    @IBAction func viewNotificationClick(_ sender: UIButton) {
        
        print(UIApplication.shared.scheduledLocalNotifications)
    }

    
    

}

