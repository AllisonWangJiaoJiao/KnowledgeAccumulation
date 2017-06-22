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
        
        let result = QRCodeTools.recognitionQRCode(image: image!, isDrawQRCodeFrame: true)
        //结果字符串
        let strs = result.resultStr
        //描绘好边框图片
        sourceImageView.image = result.resultImage
        
        let alertVC = UIAlertController(title: "结果", message: strs?.description, preferredStyle: UIAlertControllerStyle.alert)
        //添加关闭行为
        let action = UIAlertAction(title: "关闭", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
           self.dismiss(animated: true, completion: nil)
        }
        alertVC.addAction(action)
        
        present(alertVC, animated: true, completion: nil)

        
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}
