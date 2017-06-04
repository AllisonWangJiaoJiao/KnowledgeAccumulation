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
    @IBAction func sendNotificationClick(_ sender: UIButton) {
        
        //1.创建一个本地通知
        let localNot = UILocalNotification()
        //1.1设置通知的必选项
        localNot.alertBody = "顺子要不要"
        //1.2通知的发送时间
        localNot.fireDate = NSDate(timeIntervalSinceNow: 2) as Date

        //2.发送本地通知
        //应用程序界别的操作
        UIApplication.shared.scheduleLocalNotification(localNot)
        
        
    }
   
    //取消通知
    @IBAction func cancleNotificationClick(_ sender: UIButton) {
    }
    
    //查看通知
    @IBAction func viewNotificationClick(_ sender: UIButton) {
    }

    
    

}

