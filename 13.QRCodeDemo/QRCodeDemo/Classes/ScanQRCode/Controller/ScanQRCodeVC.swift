//
//  ScanQRCodeVC.swift
//  QRCodeDemo
//
//  Created by Allison on 2017/6/19.
//  Copyright © 2017年 Allison. All rights reserved.
//

import UIKit
import AVFoundation

class ScanQRCodeVC: UIViewController {

    @IBOutlet weak var scanBackView: UIView!
    
    @IBOutlet weak var scanImageView: UIImageView!
    
    @IBOutlet weak var toBottom: NSLayoutConstraint!
    
    
    var session : AVCaptureSession?
    weak var layer : AVCaptureVideoPreviewLayer?
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startScanAnimation()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        startScan()
    }
    
    func startScan() -> () {
        
        //1.获取摄像头设备
        //1.1获取摄像头设备
        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        //1.2把摄像头设备当做输入设备
        var input : AVCaptureDeviceInput?
        do {
            input = try AVCaptureDeviceInput(device: device)
        } catch  {
            print(error)
            return
        }
        
        //2.设置输出
        let output = AVCaptureMetadataOutput()
        //2.1设置结果处理的代理
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        
        //3.创建会话,连接输入和输出
        session = AVCaptureSession()
        if session!.canAddInput(input) && session!.canAddOutput(output) {
            session!.addInput(input)
            session!.addOutput(output)
        }else{
            return
        }
        //3.1设置二维码可以识别的码制
        //设置识别的类型,必须要在输出添加到会话之后,才可以设置,不然crash
        //output.availableMetadataObjectTypes
        //[AVMetadataObjectTypeQRCode]
        output.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        
        //3.2添加视频预览图层(让用户可以看到界面)(不是不许添加的)
        let layer  = AVCaptureVideoPreviewLayer(session: session)
        layer?.frame = view.layer.bounds
        //view.layer.addSublayer(layer!)
        view.layer.insertSublayer(layer!, at: 0)
        self.layer = layer
        
        //4.启动会话(让输入开始采集数据,输出对象,开始处理数据)
        session!.startRunning()
    }
}

//MARK:AVCaptureMetadataOutput
extension ScanQRCodeVC : AVCaptureMetadataOutputObjectsDelegate{
    //扫描到结果之后调用
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        print(metadataObjects)
        
        removeFrameLayer()
        for obj in metadataObjects {
            if (obj as AnyObject).isKind(of: AVMetadataMachineReadableCodeObject.self) {
                
                //转换成为二维码,再预览图层上的真正坐标
                let resultObj =  self.layer?.transformedMetadataObject(for: obj as! AVMetadataObject)
    
                let qrCodeObj = resultObj as! AVMetadataMachineReadableCodeObject
                print(qrCodeObj.stringValue)
                print("二维码的四个角:\(qrCodeObj.corners)")
                //qrCodeObj.corners 代表二维码的四个角,但是,需要借助视频预览图层,转换为我们可以用的坐标.
               drawFrame(qrCodeObj: qrCodeObj)
            }
        }
    }
    
    
    func drawFrame(qrCodeObj:AVMetadataMachineReadableCodeObject) -> () {
        guard let cornersArr = qrCodeObj.corners else {return}
        
        //1.借助一个图形层,来回执
        let shapLayer = CAShapeLayer()
        shapLayer.fillColor = UIColor.clear.cgColor
        shapLayer.strokeColor = UIColor.red.cgColor
        shapLayer.lineWidth = 6
        
        //2.根据四个点,创建一个路径
        let path = UIBezierPath()
        var index = 0
        
        for corner in cornersArr {
            let pointDic = corner as! CFDictionary
            //let point = CGPoint.zero
            let point = CGPoint.init(dictionaryRepresentation: pointDic)
            
            //第一个点
            if index == 0 {
                path.move(to: point!)
            }else{
                path.addLine(to: point!)
            }
            index += 1
        }
        
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
