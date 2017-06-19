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
        // 1.创建二维码滤镜
        let filter = CIFilter(name: "CIQRCodeGenerator")
        // 1.1回复滤镜默认设置
        filter?.setDefaults()
        
        //2.设置滤镜输入数据
        let data = "123123".data(using: String.Encoding.utf8)
        filter?.setValue(data, forKey: "inputMessage")
        
        //3.从二维码滤镜里面,获取结果图片
        var image = filter?.outputImage
        
        //
        let transform = CGAffineTransform(scaleX: 20, y: 20)
        image =  image?.applying(transform)
        
        //3.1图片处理
        let resultImage = UIImage(ciImage: image!)
        print(resultImage.size)
        //4.显示图片
        qrCodeImgView.image = resultImage
        
        
        
    }


}
