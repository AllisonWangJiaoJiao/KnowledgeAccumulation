//
//  YFDataTools.swift
//  ApplePayDemo
//
//  Created by Allison on 2017/4/28.
//  Copyright © 2017年 Allison. All rights reserved.
//

//获取需要销售的商品

import Foundation

class YFDataTools :NSObject {
    
    class func getGoodsList(result:(Set<String>)->())  {
        //先我们自己的服务器发送网络请求,获取商品数据
       result (["com.applepay.zidan","com.applepay.jiguanqiang","com.applepay.fangzi","com.applepay.yifu"])
    }
}
