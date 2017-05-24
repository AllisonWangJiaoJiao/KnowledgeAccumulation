//
//  TLog.swift
//  EnergyTaxi
//
//  Created by Allison on 2017/5/23.
//  Copyright © 2017年 Allison. All rights reserved.
//

import Foundation

//func iOS8()->Bool{return((UIDevice.current.systemVersion as NSString).floatValue >= 8.0)}
//func iOS10()->Bool{return((UIDevice.current.systemVersion as NSString).floatValue >= 10.0)}



func TLOG<T>(_ log : T?,className: String = #file,methodName: String = #function, lineNumber: Int = #line){
    #if DEBUG
        let filePath = className as NSString
        let filePath_copy = filePath.lastPathComponent as NSString
        let fileName = filePath_copy.deletingPathExtension
        NSLog("\n******[第\(lineNumber)行][\(fileName)  \(methodName)] ----\n \(log)")
    #endif
}
