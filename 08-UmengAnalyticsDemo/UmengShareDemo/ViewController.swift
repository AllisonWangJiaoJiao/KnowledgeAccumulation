//
//  ViewController.swift
//  UmengShareDemo
//
//  Created by Allison on 2017/5/4.
//  Copyright © 2017年 Allison. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        MobClick.beginLogPageView("PageOne")//("PageOne"为页面名称，可自定义)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        MobClick.endLogPageView("PageOne")
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func shareWebClick(_ sender: UIButton) {
       
        MobClick.event("analytics")
        MobClick.event("count", attributes:  ["book":"swift book"], counter: 100)
        

        
        
    }
    

    
    
}



