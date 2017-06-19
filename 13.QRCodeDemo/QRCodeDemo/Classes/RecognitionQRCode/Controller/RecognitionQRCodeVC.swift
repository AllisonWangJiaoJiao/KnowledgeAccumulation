//
//  RecognitionQRCodeVC.swift
//  QRCodeDemo
//
//  Created by Allison on 2017/6/19.
//  Copyright © 2017年 Allison. All rights reserved.
//

import UIKit

class RecognitionQRCodeVC: UIViewController {
    
    @IBOutlet weak var sourceImageView: UIImageView!
    
    
    //开始识别
    @IBAction func detectorQRCode(_ sender: UIButton) {
        
        // 1.获取需要识别的图片
        let image = sourceImageView.image
        let imageCI = CIImage(image: image!)
        
        
        //开始识别
        //1.创建一个二维码探测器
        let dector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy:CIDetectorAccuracyHigh])
        
        
        //2.直接探测二维码特征
        let features = dector?.features(in: imageCI!)
        for feature in features! {            
            let qrFeature = feature as!CIQRCodeFeature
            print(qrFeature.messageString)
            print(qrFeature.bounds)
        }
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}
