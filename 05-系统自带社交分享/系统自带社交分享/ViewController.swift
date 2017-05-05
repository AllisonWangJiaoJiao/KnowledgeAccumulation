//
//  ViewController.swift
//  系统自带社交分享
//
//  Created by Allison on 2017/5/3.
//  Copyright © 2017年 Allison. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "点击屏幕"
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        //1.判断用户是否绑定账号命名(平台)
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeSinaWeibo) {
            //2.弹出一个分享窗口,让用户开始输入内容
            let vc  = SLComposeViewController(forServiceType: SLServiceTypeSinaWeibo)
            //2.1 设置默认分享的内容
            vc?.setInitialText("系统自带的社交分享")
            vc?.add(UIImage.init(named: "tab_live"))
            vc?.add(URL(string: "http://www.baidu.com"))
            
            //2.2 监听分享状态
            vc?.completionHandler = { (result:SLComposeViewControllerResult) -> Swift.Void in
                if result == .cancelled {
                  print("取消")
                }else{
                    print("完成")
                }
            }
            present(vc!, animated: true, completion: nil)

        }else{
            print("请输入账号密码")
        }
      
        
   
    }
    
   

}


