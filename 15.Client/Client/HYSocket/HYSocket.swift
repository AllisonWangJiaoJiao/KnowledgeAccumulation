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
        
        //tcpClient.send(str: str)
        tcpClient.send(data: data)
    }
    
    
}
