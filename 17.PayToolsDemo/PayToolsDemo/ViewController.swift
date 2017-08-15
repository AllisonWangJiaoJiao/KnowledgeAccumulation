//
//  ViewController.swift
//  PayToolsDemo
//
//  Created by Allison on 2017/8/15.
//  Copyright © 2017年 Allison. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
 
       let payinfo = "2088121370516879&seller_id=13883056522@163.com&out_trade_no=YY2017081500003468&subject=移峰能源站换电预约费用&body=移峰能源换电预约产生的费用&total_fee=0.01&notify_url=http://driver.w-oasis.com/Web/api/pay/aliCallBack&service=mobile.securitypay.pay&payment_type=1&_input_charset=utf-8&it_b_pay=30m&return_url=m.alipay.com&sign=itXn8%2B0x6lSAqtucuQhmeTwwPLTI2NI%2FBA%2BifQzy82wZHsZzH0iisYgPlv%2F9yQqciZr%2Bi15l3BFHxZ0jd8TBubxYdJ0qBg%2B0S80YzlKwP41BwbKr40XX4R81qOwyvoM5hnF4pjzimV77NxglLJD%2FlQF%2Bfh7nI%2BkRa6eVolkUvqU%3D&sign_type=RSA"

    
    fileprivate  let payTool = PayTool()

    @IBAction func alipayClick(_ sender: UIButton) {
        payTool.createPayment(orderId: 558, orderType: 1, payType: 2, payinfo: payinfo)
        payTool.paySuccess = {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
     
        
    }

 

}

