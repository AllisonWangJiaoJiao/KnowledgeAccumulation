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
        
        // 1.创建二维码滤镜
        let filter = CIFilter(name: "CIQRCodeGenerator")
        // 1.1回复滤镜默认设置
        filter?.setDefaults()
        
        //2.设置滤镜输入数据
        //KVC
        let data = str.data(using: String.Encoding.utf8)
        filter?.setValue(data, forKey: "inputMessage")
        
        //2.2设置二维码的纠错率
        filter?.setValue("M", forKey: "inputCorrectionLevel")
        
        //3.从二维码滤镜里面,获取结果图片
        var image = filter?.outputImage
        
        //
        let transform = CGAffineTransform(scaleX: 20, y: 20)
        image =  image?.applying(transform)
        
        //3.1图片处理
        var resultImage = UIImage(ciImage: image!)
        print(resultImage.size)
        
        //前景图片
        let center = UIImage(named: "erha")
        resultImage = getNewImage(sourceImage: resultImage, center: center!)
        
        //4.显示图片
        qrCodeImgView.image = resultImage
        
    }
    
    func getNewImage(sourceImage:UIImage ,center:UIImage) -> UIImage {
      
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
