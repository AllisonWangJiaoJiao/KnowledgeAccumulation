//
//  ViewController.swift
//  111111
//
//  Created by Allison on 2017/11/21.
//  Copyright © 2017年 Allison. All rights reserved.
//

import UIKit
import YYModel

class ViewController: UIViewController  {

    override func viewDidLoad()  {
        super.viewDidLoad()

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let arr = self.getDataArr()
        let cityArr = NSArray.yy_modelArray(with: CityListModel.self, json: arr) as! [CityListModel]
        CityListModel.saveCityModel(cityArr: cityArr)
        sleep(2)
        print(CityListModel.getCityModelFromDie())

    }

}

extension ViewController  {

    //这个是原始的数据返回的结构
    func getDataArr() -> [Any] {
        let dic = [
            [
                "id": 9,
                "code": "100000",
                "name": "北京市",
                "baiduCode": "131",
                "gaodeCode": "",
                "tengxunCode": "",
                "parentId": 8,
                "level": 2,
                "areas": [
                    ["id": 10,
                     "code": "100020",
                     "name": "朝阳区",
                     "baiduCode": "",
                     "gaodeCode": "",
                     "tengxunCode": "",
                     "parentId": 9,
                     "level": 3,
                     "areas": "null"
                    ],
                    ["id": 13,
                     "code": "100089",
                     "name": "海淀区",
                     "baiduCode": "null",
                     "gaodeCode": "null",
                     "tengxunCode": "null",
                     "parentId": 9,
                     "level": 3,
                     "areas": "null"
                    ]
                ]
            ],
            [
                "id": 9,
                "code": "100000",
                "name": "天津",
                "baiduCode": "131",
                "gaodeCode": "11",
                "tengxunCode": "22",
                "parentId": 8,
                "level": 2,
                "areas":"lll"
            ]
        ] as [Any]
        return dic
    }

}
