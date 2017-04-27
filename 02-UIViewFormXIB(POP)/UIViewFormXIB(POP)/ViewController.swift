//
//  ViewController.swift
//  UIViewFormXIB(POP)
//
//  Created by Allison on 2017/4/27.
//  Copyright © 2017年 Allison. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //从xib中加载UIView    采用面向协议开发.
        let demoView = DemoView.loadFromNib()
        demoView.backgroundColor = UIColor.red
        demoView.name = "哈哈"
        view.addSubview(demoView)
        
        
        let testV = TestView.loadFromNib("TestView0")
        testV.backgroundColor = UIColor.green
        view.addSubview(testV)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

