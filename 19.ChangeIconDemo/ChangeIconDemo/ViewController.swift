//
//  ViewController.swift
//  ChangeIconDemo
//
//  Created by Allison on 2018/2/7.
//  Copyright © 2018年 Allison. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBAction func icon01Click(_ sender: UIButton) {
        changeIconImage(name: "icon1")
    }

    @IBAction func icon02Click(_ sender: UIButton) {
        changeIconImage(name: "icon2")
    }
    
    @IBAction func icon03Click(_ sender: UIButton) {
        changeIconImage(name: "icon3")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    fileprivate func changeIconImage(name : String) {
        if UIApplication.shared.supportsAlternateIcons { //来判断是否支持换应用图标
            //setAlertnateIconName方法有二个参数
            //第一个参数是要换图标的名字(此名字不是图片的原始名字)，如果写nil，系统默认是最初图标名字
            //第二个参数是方法执行的回调
            UIApplication.shared.setAlternateIconName(name, completionHandler: { (error) in
                if (error != nil) {
                    print(error ?? "失败")
                } else {
                    print("成功")
                }
            })
        }
    }

}

