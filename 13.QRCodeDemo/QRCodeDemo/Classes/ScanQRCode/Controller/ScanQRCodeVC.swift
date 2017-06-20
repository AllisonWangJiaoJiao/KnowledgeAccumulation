//
//  ScanQRCodeVC.swift
//  QRCodeDemo
//
//  Created by Allison on 2017/6/19.
//  Copyright © 2017年 Allison. All rights reserved.
//

import UIKit

class ScanQRCodeVC: UIViewController {

    @IBOutlet weak var scanBackView: UIView!
    
    @IBOutlet weak var scanImageView: UIImageView!
    
    @IBOutlet weak var toBottom: NSLayoutConstraint!
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startScanAnimation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        removeScanAnimation()
    }

  
}

extension ScanQRCodeVC {
    
    func startScanAnimation() -> () {
        
        toBottom.constant = scanBackView.frame.size.height - 10
        view.layoutIfNeeded()
        toBottom.constant = 10
        
        UIView.animate(withDuration: 1) {
            UIView.setAnimationRepeatCount(MAXFLOAT)
            self.view.layoutIfNeeded()
        }
    }
    
    
    func removeScanAnimation() {
        scanImageView.layer.removeAllAnimations()
    }

}
