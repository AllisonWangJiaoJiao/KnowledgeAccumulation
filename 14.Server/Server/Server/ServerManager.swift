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
    
    fileprivate var isServerRunning :Bool = false
    
    fileprivate var clientMgrsArr : [ClientManager] = [ClientManager]()
}

extension ServerManager {
    
    func statrRuning() {
        
        //1.开启监听
        serverSocket.listen()
        isServerRunning = true
        
        //2.开始接受客户端
        DispatchQueue.global().async {
            while self.isServerRunning {
                if let client = self.serverSocket.accept(){
                    DispatchQueue.global().async {
                        self.handleClient(client)
                    }
                }
            }
        } 
    }
    
    
    func stopRuning() {
        
    }
    
    
}

extension ServerManager {
    
    fileprivate func handleClient(_ client : TCPClient ){
        //1.用一个ClientManager管理TCPClient
        let mgr = ClientManager(tcpClient: client)
        mgr.delegate = self
        //2.保存客户端
        clientMgrsArr.append(mgr)
        
        //3.用client开始接受消息
        mgr.startReadMsg()
        
    }
    
}


extension ServerManager :ClientManagerDelegate {
    func sendMsgToClient(_ data: Data) {
        for mgr in clientMgrsArr {
            mgr.tcpClient.send(data: data)
        }
    }
}



