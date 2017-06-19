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
        
        var result = [String]()
        
        var resultImage = image        
        //2.直接探测二维码特征
        let features = dector?.features(in: imageCI!)
        for feature in features! {
            let qrFeature = feature as!CIQRCodeFeature
            print(qrFeature.messageString)
            result.append(qrFeature.messageString!)
            resultImage = drawFrame(image: resultImage!, feature: qrFeature)
            sourceImageView.image = resultImage
            
        }
        let alertVC = UIAlertController(title: "结果", message: result.description, preferredStyle: UIAlertControllerStyle.alert)
        
        //添加关闭行为
        let action = UIAlertAction(title: "关闭", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
           self.dismiss(animated: true, completion: nil)
        }
        alertVC.addAction(action)
        
        present(alertVC, animated: true, completion: nil)

        
    }
    
    func drawFrame(image:UIImage,feature:CIQRCodeFeature) -> UIImage {
      
        let size = image.size
        
        //1.开启图形上下文
        UIGraphicsBeginImageContext(size)
        
        //2.绘制打图片
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        
        //转换坐标系(上下颠倒)
        let context = UIGraphicsGetCurrentContext()
        context?.scaleBy(x: 1, y: -1)
        context?.translateBy(x: 0, y: -size.height)
        
        //3.绘制路径
        let bounds = feature.bounds
        let path = UIBezierPath(rect: bounds)
        UIColor.red.setStroke()
        path.lineWidth = 6
        path.stroke()
      
        //4.取出结果图片
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        
        //5.关闭上下文
        UIGraphicsEndImageContext()
        
        //6.返回结果
        return resultImage!
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}
