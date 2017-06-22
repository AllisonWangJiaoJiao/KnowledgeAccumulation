//
//  QRCodeTools.swift
//  QRCodeDemo
//
//  Created by Allison on 2017/6/22.
//  Copyright © 2017年 Allison. All rights reserved.
//

import UIKit
import AVFoundation

typealias ScanResultBlock = ([String])->()

class QRCodeTools: NSObject {
    
    ///设置单利对象
    static let shareInstance = QRCodeTools()
    
    ///懒加载输入对象
    lazy var input :AVCaptureDeviceInput? = {
        //1.设置输入
        //1.1获取摄像头设备
        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        //1.2把摄像头设备当做输入设备
        var input : AVCaptureDeviceInput?
        do {
            input = try AVCaptureDeviceInput(device: device)
            return input
        } catch  {
            print(error)
            return nil
        }
    }()
    
    ///懒加载输出对象
    lazy var output :AVCaptureMetadataOutput = {
        //2.设置输出
        let output = AVCaptureMetadataOutput()
        //2.1设置结果处理的代理
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        return output
    }()
    
    //懒加载会话对象
    lazy var session : AVCaptureSession = {
        //3.创建会话,连接输入和输出
        let session = AVCaptureSession()
        return session
    }()
    
    ///懒加载layer
    lazy var layer :AVCaptureVideoPreviewLayer? = {
        let layer =  AVCaptureVideoPreviewLayer(session: self.session)
        return layer
    }()
    
    ///闭包
   fileprivate var scanResultBlock : ScanResultBlock?
    //记录
    fileprivate var isDrawFrame: Bool = false

    //扫描二维码
    func scanQRCode(inView:UIView,isDrawFrame:Bool, resultBlock:@escaping (_ resultStrs:[String])->()){
        //记录闭包
        scanResultBlock = resultBlock
        //记录绘制边框
        self.isDrawFrame = isDrawFrame
        
        if session.canAddInput(input) && session.canAddOutput(output) {
            session.addInput(input)
            session.addOutput(output)
        }else{
            return
        }

        //3.1设置二维码可以识别的码制
        //设置识别的类型,必须要在输出添加到会话之后,才可以设置,不然crash
        //output.availableMetadataObjectTypes
        //[AVMetadataObjectTypeQRCode]
        output.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        
        
        
        //3.2添加视频预览图层(让用户可以看到界面)(不是不许添加的)
        if inView.layer.sublayers == nil {
            layer?.frame = inView.layer.bounds
            //view.layer.addSublayer(layer!)
            inView.layer.insertSublayer(layer!, at: 0)
        }else{
            let subLayers = inView.layer.sublayers!
            
            if !subLayers.contains(layer!) {
                layer?.frame = inView.layer.bounds
                inView.layer.insertSublayer(layer!, at: 0)
            }
        }
 
        //4.启动会话(让输入开始采集数据,输出对象,开始处理数据)
        session.startRunning()

    }
    
    //设置扫码的兴趣区域
    func setRectInterest(orignRect:CGRect) -> () {
        //CGRectMake(0, 0, 1, 1)
        //0,0 右上角
        let bounds = UIScreen.main.bounds
        let x :CGFloat = orignRect.origin.x / bounds.size.width
        let y :CGFloat = orignRect.origin.y / bounds.size.height
        let width : CGFloat = orignRect.size.width / bounds.size.width
        let height : CGFloat = orignRect.size.height / bounds.size.height
        output.rectOfInterest = CGRect(x: y, y: x, width: height, height: width)
        //output.rectOfInterest = CGRect(x: x, y: y, width: width, height: height)
   
    }
    
    
    
    /// 识别图片二维码
    ///
    /// - Parameters:
    ///   - image: 原始图片
    ///   - isDrawQRCodeFrame: 是否需要绘制扫描边框
    /// - Returns: 元组(结果字符串组成的数组,绘制好二维码边框的图片(如果不要求绘制,则返回的是原始图片))
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
    
    
    /// 生成二维码
    ///
    /// - Parameters:
    ///   - inputStr: 需要转换的字符串
    ///   - centerImage: 字符串中间的自定义图片
    /// - Returns: 生成后的结果图片
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


//MARK:AVCaptureMetadataOutput
extension QRCodeTools : AVCaptureMetadataOutputObjectsDelegate{
        //扫描到结果之后调用
        func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
            print(metadataObjects)
            
            if isDrawFrame {
                removeFrameLayer()
            }
            
            var resultStrsArr = [String]()
            for obj in metadataObjects {
                if (obj as AnyObject).isKind(of: AVMetadataMachineReadableCodeObject.self) {
                    
                    //转换成为二维码,再预览图层上的真正坐标
                    let resultObj =  layer?.transformedMetadataObject(for: obj as! AVMetadataObject)
                    let qrCodeObj = resultObj as! AVMetadataMachineReadableCodeObject
                    //将数据添加到数组
                    resultStrsArr.append(qrCodeObj.stringValue)
                    //print(qrCodeObj.stringValue)
                    //print("二维码的四个角:\(qrCodeObj.corners)")
                    //qrCodeObj.corners 代表二维码的四个角,但是,需要借助视频预览图层,转换为我们可以用的坐标.
                    if isDrawFrame {
                         drawFrame(qrCodeObj: qrCodeObj)
                    }
                }
            }
            
            if let scanResultBlock  = scanResultBlock {
                scanResultBlock(resultStrsArr)
            }
            
//            if scanResultBlock != nil {
//                scanResultBlock(resultStrsArr)
//            }
        }
        
        
        func drawFrame(qrCodeObj:AVMetadataMachineReadableCodeObject) -> () {
            guard let cornersArr = qrCodeObj.corners else {return}
            
            //1.借助一个图形层,来回执
            let shapLayer = CAShapeLayer()
            shapLayer.fillColor = UIColor.clear.cgColor
            shapLayer.strokeColor = UIColor.red.cgColor
            shapLayer.lineWidth = 3
            
            //2.根据四个点,创建一个路径
            let path = UIBezierPath()
            var index = 0
            
            for corner in cornersArr {
                let pointDic = corner as! CFDictionary
                var point = CGPoint.zero
                point = CGPoint.init(dictionaryRepresentation: pointDic)!
                
                //第一个点
                if index == 0 {
                    path.move(to: point)
                }else{
                    path.addLine(to: point)
                }
                index += 1
            }
            path.close()
            
            //3.给图形图层的路径赋值,代表图层展示怎样的形状
            shapLayer.path = path.cgPath
            
            //4.直接添加图形图层到需要展示的图层
            layer?.addSublayer(shapLayer)
        }
        
        func removeFrameLayer() -> () {
            guard let subLayers = layer?.sublayers else {return}
            
            for subLayer in subLayers {
                if subLayer.isKind(of: CAShapeLayer.self) {
                    subLayer.removeFromSuperlayer()
                }
            }
        }
        
}



