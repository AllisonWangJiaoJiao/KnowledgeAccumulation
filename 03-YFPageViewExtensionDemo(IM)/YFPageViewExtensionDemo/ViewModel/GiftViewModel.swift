//
//  GiftViewModel.swift
//  XMGTV
//
//  Created by apple on 16/11/13.
//  Copyright © 2016年 coderwhy. All rights reserved.
//

import UIKit

class GiftViewModel {
    lazy var giftlistArr : [GiftPackage] = [GiftPackage]()
}

extension GiftViewModel {
    func loadGiftData(finishedCallback : @escaping () -> ()) {

        let path = Bundle.main.path(forResource: "GiftList.json", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        // data 一定会有一个内容，反序列化
        // 反序列化转换成数组
        guard let dataDict = try? JSONSerialization.jsonObject(with: data! as Data, options: []) as? [String:Any]
            else {
                return
        }
        
        for i in 0..<dataDict!.count {
            guard let dict = dataDict!["type\(i+1)"] as? [String : Any] else { continue }
            self.giftlistArr.append(GiftPackage(dict: dict))
        }
        self.giftlistArr = self.giftlistArr.filter({ return $0.t != 0 }).sorted(by: { return $0.t > $1.t })
    }
}
