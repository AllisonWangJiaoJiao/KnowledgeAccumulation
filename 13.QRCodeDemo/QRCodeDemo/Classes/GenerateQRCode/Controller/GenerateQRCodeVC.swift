//
//  GenerateQRCodeVC.swift
//  QRCodeDemo
//
//  Created by Allison on 2017/6/19.
//  Copyright © 2017年 Allison. All rights reserved.
//

import UIKit
import CoreImage

class GenerateQRCodeVC: UIViewController {
    
    @IBOutlet weak var qrCodeImgView: UIImageView!

    @IBOutlet weak var inputTV: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        view.endEditing(true)
        
        let str = inputTV.text ?? ""
        
        let image = QRCodeTools.generateQRCode(inputStr: str, centerImage: UIImage.init(named: "erha"))
        qrCodeImgView.image = image
        
    }
   

}
