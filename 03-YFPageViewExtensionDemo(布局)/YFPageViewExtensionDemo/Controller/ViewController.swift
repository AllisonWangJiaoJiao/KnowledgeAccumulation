//
//  ViewController.swift
//  YFPageViewExtensionDemo
//
//  Created by Allison on 2017/5/21.
//  Copyright © 2017年 Allison. All rights reserved.
//

import UIKit

private let kEmoticonCell = "kEmoticonCell"

class ViewController: UIViewController {
    
 
    
    @IBAction func chatClick(_ sender: UIButton) {
        
        let roomVc = RoomViewController()
        navigationController?.pushViewController(roomVc, animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
  
        
    }
}
