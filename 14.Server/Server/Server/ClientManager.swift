//
//  ClientManager.swift
//  Server
//
//  Created by Allison on 2017/7/5.
//  Copyright © 2017年 Allison. All rights reserved.
//

import Cocoa

class ClientManager: NSObject {
    
    var tcpClient : TCPClient
    
    fileprivate var isClientConnected : Bool = false
    
    init(tcpClient:TCPClient) {
        self.tcpClient = tcpClient
        
        
    }
}

extension ClientManager {
    func startReadMsg()  {
        
        isClientConnected = true
        while true {
            
            if let lMsg = tcpClient.read(4){
                //1.读取长度的data
                let msgData = Data(bytes: lMsg, count: 4)
                var length : Int = 0
                    (msgData as NSData).getBytes(&length, length: 4)
                
                //2.读取类型
                guard let typeMsg = tcpClient.read(2) else {return}
                let typeData = Data(bytes: typeMsg, count: 2)
                var type : Int = 0
                (typeData as NSData).getBytes(&type, length: 2)
                print("type:\(type)")
                
                //2.根据长度,读取真实消息
                guard let msg = tcpClient.read(length) else {return}
                let data = Data(bytes: msg, count: length)
                switch type {
                case 0 , 1:
                    //parseFrom 反序列化(解析)
                  let user =  try! UserInfo.parseFrom(data: data)
                    print(user.name)
                    print(user.level)
                default:
                    print("未知类型")
                }
                
                
                
                
                
                
            }else{
                isClientConnected = false
                print("客户端断开连接")
            }

        }
        
    }
}
