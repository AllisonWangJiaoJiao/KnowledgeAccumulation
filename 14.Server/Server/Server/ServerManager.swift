//
//  ServerManager.swift
//  Server
//
//  Created by Allison on 2017/7/4.
//  Copyright © 2017年 Allison. All rights reserved.
//

import Cocoa

class ServerManager: NSObject {

    fileprivate lazy var serverSocket : TCPServer = TCPServer.init(addr: "0.0.0.0", port: 7878)
    
    
}

extension ServerManager {
    
    func statrRuning() {
        
        //1.开启监听
        serverSocket.listen()
        
        //2.开始接受客户端
        DispatchQueue.global().async {
            if let client = self.serverSocket.accept(){
             print("接受到一个客服端的连接")
            }
        }
        
        //3.
        
        
        
        
    }
    
    
    func stopRuning() {
        
    }
    
    
}
