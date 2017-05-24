//
//  ViewController.swift
//  WKWebProgressDemo
//
//  Created by Allison on 2017/5/22.
//  Copyright © 2017年 Allison. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
          stupUI()
    }

   
}

//MARK:-设置UI
extension ViewController{
    func stupUI()  {
        
        let btn = UIButton.init(type: .custom)
        btn.frame = CGRect(x: 10, y:64, width: 100, height: 40)
        btn.setTitle("跳转", for: UIControlState.normal)
        btn.addTarget(self, action: #selector(quitButClick), for: UIControlEvents.touchUpInside)
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.backgroundColor = #colorLiteral(red: 0.1379139125, green: 0.66092664, blue: 0.9643357396, alpha: 1)
        view.addSubview(btn)
        
    }
    
    //退出提示框
    func quitButClick() {
        print("跳转")
        
        let webVC  = BaseWebViewController()
        self.navigationController?.pushViewController(webVC, animated: true)
        
    }
}
