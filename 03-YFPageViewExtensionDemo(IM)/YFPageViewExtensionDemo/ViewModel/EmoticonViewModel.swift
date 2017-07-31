//
//  EmoticonViewModel.swift
//  XMGTV
//
//  Created by apple on 16/11/14.
//  Copyright © 2016年 coderwhy. All rights reserved.
//


import UIKit

class EmoticonViewModel {
    
    ///单利对象
    static let shareInstance : EmoticonViewModel = EmoticonViewModel()
    lazy var packagesArr : [EmoticonPackage] = [EmoticonPackage]()
    
    init() {
        packagesArr.append(EmoticonPackage(plistName: "QHNormalEmotionSort.plist"))
        packagesArr.append(EmoticonPackage(plistName: "QHSohuGifSort.plist"))
    }
}
