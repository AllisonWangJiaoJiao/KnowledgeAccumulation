//
//  CityListModel.swift
//  TimeShareLease
//
//  Created by Allison on 2017/11/21.
//  Copyright © 2017年 Allison. All rights reserved.
//

import Foundation
import YYModel

class CityListModel: NSObject,NSCoding,YYModel {

    var areas : [CityListModel]?
    var baiduCode : String?
    var code : String?
    var gaodeCode : String?
    var ids : Int = 0
    var level : Int = 0
    var name : String?
    var parentId : Int = 0
    var tengxunCode : String?

    override init() {
        super.init()
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        self.yy_modelInit(with: aDecoder)
    }
    
    func encode(with aCoder: NSCoder) {
        self.yy_modelEncode(with: aCoder)
    }

    static func modelCustomPropertyMapper() -> [String : Any]? {
        return ["ids":"id"]
    }
    static func modelContainerPropertyGenericClass() -> [String : Any]? {
        return ["areas":CityListModel.classForCoder()]
    }
    
    override var description: String {
        return yy_modelDescription()
    }
    
    class func getSavePath() -> String{
        let docPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as NSString
        let path = (docPath as String) + "/cityList.plist"
        print(path)
        return path
    }
    
    class func saveCityModel(cityArr:[CityListModel]) {
        let path = getSavePath()
        NSKeyedArchiver.archiveRootObject(cityArr, toFile: path)
    }
    
    class func getCityModelFromDie() -> [CityListModel]{
        let cityModel = NSKeyedUnarchiver.unarchiveObject(withFile: getSavePath())
        return cityModel as! [CityListModel]
    }
    
}

/*
class Area : NSObject {
    var areas : Any?
    var baiduCode : String?
    var code : String?
    var gaodeCode : String?
    var id : Int = 0
    var level : Int?
    var name : String?
    var parentId : Int = 0
    var tengxunCode : String?
}*/
