//
//  SecondViewController.swift
//  UmengShareDemo
//
//  Created by Allison on 2017/5/5.
//  Copyright © 2017年 Allison. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MobClick.beginLogPageView("PageSecond")//("PageOne"为页面名称，可自定义)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        MobClick.endLogPageView("PageSecond")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let array = [1,2]
        print(array[3])
        
    }

}
