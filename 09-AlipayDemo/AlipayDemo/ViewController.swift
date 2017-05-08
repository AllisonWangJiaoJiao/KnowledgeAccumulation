//
//  ViewController.swift
//  AlipayDemo
//
//  Created by Allison on 2017/5/5.
//  Copyright © 2017年 Allison. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func alipayClick(_ sender: UIButton) {
        
        alipayFunc()
    }

}

extension ViewController{
    
   fileprivate  func alipayFunc() -> () {
   
    let rsa2PrivateKey = ""
    let rsaPrivateKey = kRsaPrivateKey;
    
     let order = Order()
    order.app_id = appId
    // NOTE: 支付接口名称
    order.method = "alipay.trade.app.pay"
    // NOTE: 参数编码格式
    order.charset = "utf-8"
    // NOTE: 当前时间点
    let formatter:DateFormatter = DateFormatter()
    formatter.dateFormat        = "yyyy-MM-dd HH:mm:ss"
    order.timestamp = formatter.string(from: Date())
    
    // NOTE: 支付版本
    order.version = "1.0";
    
    // NOTE: sign_type设置
    order.sign_type = "RSA";
    
    // NOTE: 商品数据
    order.biz_content = BizContent()
    //商品描述
    order.biz_content.body = "我是测试数据";
    //商品的标题/交易标题/订单标题/订单关键字等
    order.biz_content.subject = "1";
   // 商户网站唯一订单号
//    order.biz_content.out_trade_no =   //订单ID（由商家自行制定）
    order.biz_content.timeout_express = "30m" //超时时间设置
    //订单总金额
//    order.biz_content.total_amount =  String(format: "%.2f", order.biz_content.total_amount) //商品价格
    order.biz_content.seller_id = "18721450464" //收款支付宝用户ID
    //回调url
    order.notify_url = "http://www.baidu.com"
    
    let appScheme = "AlipayDemo"
    let orderSpec = order.description
    
    //将商品信息拼接成字符串
    let orderInfo = order.orderInfoEncoded(false)
    let orderInfoEncoded = order.orderInfoEncoded(true)
    print(orderInfo)
    
    //对订单进行加密签名
    var signedString = ""
    guard let signer = RSADataSigner.init(privateKey: rsa2PrivateKey.characters.count > 1 ?rsa2PrivateKey:rsaPrivateKey) else{
        return
    }
    if ((rsa2PrivateKey.characters.count > 1)) {
        signedString = signer.sign(orderInfo, withRSA2: false)
    } else {
        signedString = signer.sign(orderInfo, withRSA2: true)
    }
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != "") {
        
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        let appScheme = "alisdkdemo";
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        let orderString = String(format:"%.2f ", orderInfoEncoded!) + signedString
        
        
        // NOTE: 调用支付结果开始支付
        AlipaySDK.defaultService().payOrder(orderString, fromScheme: appScheme, callback: { (dict:[AnyHashable : Any]?) in
            print(dict)
        })
        
        
    }
    }
}










