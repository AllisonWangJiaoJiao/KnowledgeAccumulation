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
        
        
        setupToolView()
    }

   
}

//MARK:-设置UI
extension ViewController{
    
   fileprivate func setupToolView()  {
        let tooBar = UIToolbar.init(frame: CGRect(x: 0, y: UIScreen.cz_screenHeight() - 40, width: UIScreen.cz_screenWidth(), height: 40))
        view.addSubview(tooBar)
    
    let fixedSpace = UIBarButtonItem.init(barButtonSystemItem:.flexibleSpace, target: self, action: nil)
    let backButton = UIBarButtonItem.init(barButtonSystemItem: .rewind, target: self, action: nil)
    let forwardButton = UIBarButtonItem.init(barButtonSystemItem: .fastForward, target: self, action: nil)
    let refreshButton = UIBarButtonItem.init(barButtonSystemItem: .refresh, target: self, action: nil)
    tooBar.setItems([fixedSpace,backButton,forwardButton,refreshButton], animated: true)

    }
}
