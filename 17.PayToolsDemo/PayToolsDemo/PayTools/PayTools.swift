//
//  PayTools.swift
//  PayToolsDemo
//
//  Created by Allison on 2017/8/15.
//  Copyright © 2017年 Allison. All rights reserved.
//

import Foundation


class PayTool {
    var canPay : Bool = true
    /// 支付成功回调
    var paySuccess : (()->())?
    
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(alipayBack), name: NSNotification.Name(rawValue: AlipayBackNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(wechatPayDidDone), name: NSNotification.Name(rawValue: WXpayBackNotification), object: nil)
    }
    
    
    /// 正常调用支付宝app通过appdelegate中返回结果，通过发通知在本处调用
    @objc private func alipayBack(notification : Notification) {
        
        
    
    }
    
    @objc private func wechatPayDidDone(notification : Notification){
        
        
        
    }
    
    
}
