//
//  ViewController.swift
//  01-粒子动画效果
//
//  Created by Allison on 2017/4/27.
//  Copyright © 2017年 Allison. All rights reserved.
//

import UIKit

class ViewController: UIViewController,Emitterable {
    
     var isSelected : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let point = CGPoint(x: view.frame.maxX - 50, y:view.frame.maxY - 50)
        self.isSelected = !self.isSelected
        self.isSelected ? startEmittering(point) : stopEmittering()
        
    }


}

