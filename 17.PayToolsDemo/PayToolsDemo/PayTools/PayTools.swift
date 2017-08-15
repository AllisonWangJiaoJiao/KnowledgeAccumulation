//
//  PayTools.swift
//  PayToolsDemo
//
//  Created by Allison on 2017/8/15.
//  Copyright © 2017年 Allison. All rights reserved.
//

import Foundation
import SVProgressHUD

class PayTool {
    var canPay : Bool = true
    /// 支付成功回调
    var paySuccess : (()->())?
    
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(alipayBack), name: NSNotification.Name(rawValue: AlipayBackNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(wechatPayDidDone), name: NSNotification.Name(rawValue: WXpayBackNotification), object: nil)
    }
    
    
    /// 支付
    ///
    /// - Parameters:
    ///   - orderId: 订单id，预约单ID，换电单，救援工单
    ///   - orderType:工单类型，1 预约单ID，2 换电单，3救援工单
    ///   - payType: 支付方式，1微信 2支付宝
    func createPayment(orderId : Int, orderType : Int, payType : Int,payinfo:String) {
        
        if payType == 2{//支付宝支付
            self.pay_alipay(order: payinfo, scheme: appScheme)
        }
        
    }
    
    private func pay_alipay(order : String, scheme : String) {
        let alipaySDK = AlipaySDK.defaultService()
        alipaySDK?.payOrder(order, fromScheme: scheme, callback: { (resultDic) in
            //快捷支付开发包回调函数，返回免登、支付结果。本地未安装支付宝客户端，或未成功调用支付宝客户端进行支付的情况下（走H5收银台），会通过该本callback返回支付结果。
            self.alipayPayDidDone(resultDic: resultDic ?? [:])
            self.canPay = true
        })
    }
    
    private func alipayPayDidDone(resultDic : [AnyHashable : Any]) -> Void{
        if let status = resultDic["resultStatus"] as? String{
            switch status {
            case "9000" :
                SVProgressHUD.showSuccess(withStatus: "支付成功")
                if self.paySuccess != nil {
                    self.paySuccess!()
                }
            case "8000" :
                  SVProgressHUD.showInfo(withStatus: "正在处理中")
            case "4000" :
                SVProgressHUD.showError(withStatus: "订单支付失败")
            case "6001" :
                SVProgressHUD.showInfo(withStatus: "取消支付")
            case "6002" :
                SVProgressHUD.showError(withStatus: "网络连接出错")
            default :
                if let memo = resultDic["memo"] as? String{
                     SVProgressHUD.showError(withStatus: memo)
                } else {
                     SVProgressHUD.showError(withStatus: "支付失败")
                }
            }
        }
    }
    

    
    
    /// 正常调用支付宝app通过appdelegate中返回结果，通过发通知在本处调用
    @objc private func alipayBack(notification : Notification) {
        
        if let resultDic = notification.object as? [AnyHashable : Any] {
            alipayPayDidDone(resultDic: resultDic)
        }
    
    }
    
    @objc private func wechatPayDidDone(notification : Notification){
        
        
        
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: AlipayBackNotification), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: WXpayBackNotification), object: nil)
    }
    
    
}
