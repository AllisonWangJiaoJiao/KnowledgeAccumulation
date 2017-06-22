//
//  QRCodeTools.swift
//  QRCodeDemo
//
//  Created by Allison on 2017/6/22.
//  Copyright © 2017年 Allison. All rights reserved.
//

import UIKit

class QRCodeTools: NSObject {
    
    
    
    //识别图片二维码
    class func recognitionQRCode(image:UIImage,isDrawQRCodeFrame:Bool)->(resultStr:[String]?,resultImage:UIImage) {
        
        let imageCI = CIImage(image: image)
        //开始识别
        //1.创建一个二维码探测器
        let dector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy:CIDetectorAccuracyHigh])
        //2.直接探测二维码特征
        let features = dector?.features(in: imageCI!)
        
        var result = [String]()
        //处理存储好的图片
        var resultImage = image
        
        for feature in features! {
            let qrFeature = feature as!CIQRCodeFeature
            //print(qrFeature.messageString ?? "")
            result.append(qrFeature.messageString!)
           
            //sourceImageView.image = resultImage
            if isDrawQRCodeFrame {
                resultImage = drawFrame(image: resultImage, feature: qrFeature)
            }
        }
        return (result,resultImage)
        
    }
    
    //生成二维码
    class func generateQRCode(inputStr:String,centerImage:UIImage?) -> UIImage {
        
        // 1.创建二维码滤镜
        let filter = CIFilter(name: "CIQRCodeGenerator")
        // 1.1回复滤镜默认设置
        filter?.setDefaults()
        
        //2.设置滤镜输入数据
        //KVC
        let data = inputStr.data(using: String.Encoding.utf8)
        filter?.setValue(data, forKey: "inputMessage")
        
        //2.2设置二维码的纠错率
        filter?.setValue("M", forKey: "inputCorrectionLevel")
        
        //3.从二维码滤镜里面,获取结果图片
        var image = filter?.outputImage
        
        let transform = CGAffineTransform(scaleX: 20, y: 20)
        image =  image?.applying(transform)
        
        //3.1图片处理
        var resultImage = UIImage(ciImage: image!)
        
        //前景图片
//        let center = UIImage(named: "erha")
        if centerImage != nil {
            resultImage = getNewImage(sourceImage: resultImage, center: centerImage!)
        }
        
        //4.显示图片
        return resultImage
    }

}

extension QRCodeTools {
    
    //识别图片二维码
   class fileprivate func drawFrame(image:UIImage,feature:CIQRCodeFeature) -> UIImage {
        
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
    
    //生成二维码
    class fileprivate func getNewImage(sourceImage:UIImage ,center:UIImage) -> UIImage {
        
        let size = sourceImage.size
        //1.开启图形上下文
        UIGraphicsBeginImageContext(size)
        //2.绘制大图片
        sourceImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        //3.绘制小图片
        let width : CGFloat = 80
        let height : CGFloat = 80
        let x :CGFloat = (size.width - width) * 0.5
        let y :CGFloat = (size.height - height) * 0.5
        center.draw(in: CGRect(x: x, y: y, width: width, height: height))
        
        //4.取出结果图片
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        
        //5.关闭上下文
        UIGraphicsEndImageContext()
        
        //6.返回结果
        return resultImage!
    }
}
