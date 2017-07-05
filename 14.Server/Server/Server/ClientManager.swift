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
            
            if let msg = tcpClient.read(20){
                
                let msgData = Data(bytes: msg, count: 20)
                let msgStr = String(data: msgData, encoding: String.Encoding.utf8)
                print(msgStr ?? "123")
                
            }else{
                isClientConnected = false
                print("客户端断开连接")
            }

        }
        
    }
}
