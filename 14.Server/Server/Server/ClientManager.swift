//
//  ClientManager.swift
//  Server
//
//  Created by Allison on 2017/7/5.
//  Copyright © 2017年 Allison. All rights reserved.
//

import Cocoa

protocol ClientManagerDelegate :class{
    //发送消息到其它客户端
    func sendMsgToClient(_ data: Data)
    func removeClient(_ client:ClientManager)
}

class ClientManager: NSObject {
    
    var tcpClient : TCPClient
    
    weak var delegate : ClientManagerDelegate?
    
    fileprivate var isClientConnected : Bool = false
    
    //fileprivate var revHeartBeat : Bool = false
     fileprivate var heatTimeCount : Int = 0
    
    init(tcpClient:TCPClient) {
        self.tcpClient = tcpClient
        
        
    }
}

extension ClientManager {
    func startReadMsg()  {
        
        isClientConnected = true
        
        let timer = Timer(fireAt: Date(), interval: 1, target: self, selector: #selector(checkHeartBeat), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: RunLoopMode.defaultRunLoopMode)
        timer.fire()
        print("++++++++")
        
        while true {
            
            if let lMsg = tcpClient.read(4){
                //1.读取长度的data
                let headData = Data(bytes: lMsg, count: 4)
                var length : Int = 0
                    (headData as NSData).getBytes(&length, length: 4)
                
                //2.读取类型
                guard let typeMsg = tcpClient.read(2) else {return}
                let typeData = Data(bytes: typeMsg, count: 2)
                var type : Int = 0
                (typeData as NSData).getBytes(&type, length: 2)
                print("type:\(type)")
                
                //2.根据长度,读取真实消息
                guard let msg = tcpClient.read(length) else {return}
                let msgData = Data(bytes: msg, count: length)
       
                if type == 1 {
                    _ = tcpClient.close()
                    delegate?.removeClient(self)
                }else if type == 100 {//心跳包
                    heatTimeCount = 0
                    let msg = String.init(data: msgData, encoding: String.Encoding.utf8)
                    print(msg)
                    continue
                }
                
                let totalData = headData + typeData + msgData
                delegate?.sendMsgToClient(totalData)
          
                
            }else{
               self.removeClient()
            }

        }
        
    }
    
    @objc fileprivate func checkHeartBeat() {
        
        print("------")

        heatTimeCount += 1
        if heatTimeCount >= 10 {
            removeClient()
        }
        
    }
    
    fileprivate func removeClient(){
      
        delegate?.removeClient(self)
        isClientConnected = false
        print("客户端断开连接")
        _ = tcpClient.close()


    }
    
}
