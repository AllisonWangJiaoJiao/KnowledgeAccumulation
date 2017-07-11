//
//  HYSocket.swift
//  Client
//
//  Created by Allison on 2017/7/4.
//  Copyright © 2017年 Allison. All rights reserved.
//

import UIKit

class HYSocket {
    
    fileprivate  var tcpClient : TCPClient
    
    init(addr:String, port:Int) {
        tcpClient = TCPClient(addr: addr, port: port)
    }

}


extension HYSocket {
    
    func connectServer() -> Bool{
        //设置超时时间
      return  tcpClient.connect(timeout: 5).0
    }
   
    func sendMsg(data:Data) {
        tcpClient.send(data: data)
    }
    
    //开始接受消息
    func startReadMsg()  {
        
        DispatchQueue.global().async {
            while true {
      
                guard let lMsg = self.tcpClient.read(4) else{continue}
                //1.读取长度的data
                let headData = Data(bytes: lMsg, count: 4)
                var length : Int = 0
                (headData as NSData).getBytes(&length, length: 4)
                
                //2.读取类型
                guard let typeMsg = self.tcpClient.read(2) else {return}
                let typeData = Data(bytes: typeMsg, count: 2)
                var type : Int = 0
                (typeData as NSData).getBytes(&type, length: 2)
                print("type:\(type)")
                
                //2.根据长度,读取真实消息
                guard let msg = self.tcpClient.read(length) else {return}
                let msgData = Data(bytes: msg, count: length)
                
                switch type {
                case 0 , 1:
                    //parseFrom 反序列化(解析)
                    let user =  try! UserInfo.parseFrom(data: msgData)
                    print(user.name)
                    print(user.level)
                default:
                    print("未知类型")
                }
                
            }
        }
        
    
    }
    
    
}
