//
//  RootViewController.swift
//  YifengEnergy
//
//  Created by 吴强 on 17/3/15.
//  Copyright © 2017年 ChongqingWirelessOasisCommunicationTechnology. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    let screenW = UIScreen.main.bounds.width
    
    var mainVC: UIViewController?
   
    //MARK: - 单例
//    static let shareDrawer = UIApplication.shared.keyWindow?.rootViewController as? RootViewController
    
    init(mainVC: UIViewController) {
        
        super.init(nibName: nil, bundle: nil)
        
        self.mainVC = mainVC
        mainVC.view.frame = view.bounds

        view.addSubview(mainVC.view)

        addChildViewController(mainVC)
        
    }
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

