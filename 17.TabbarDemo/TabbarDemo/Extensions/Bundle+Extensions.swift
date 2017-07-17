//
//  Bundle+Extensions.swift
//  YifengEnergy
//
//  Created by 吴强 on 17/3/14.
//  Copyright © 2017年 ChongqingWirelessOasisCommunicationTechnology. All rights reserved.
//

import Foundation

extension Bundle {
    // 计算型属性类似于函数，没有参数，有返回值
    var namespace: String {
        return infoDictionary?["CFBundleName"] as? String ?? ""
    }
    
    var currentVersion : String {
        return infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
    }
}
