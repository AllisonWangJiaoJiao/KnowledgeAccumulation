//
//  HYSocket.swift
//  Client
//
//  Created by Allison on 2017/7/4.
//  Copyright © 2017年 Allison. All rights reserved.
//

import UIKit

protocol HYSocketDelegate :class{
    func socket(_ socket : HYSocket,joinRom user:UserInfo)
    func socket(_ socket : HYSocket,leaveRom user:UserInfo)
    func socket(_ socket : HYSocket,textMsg :TextMessage)
    func socket(_ socket : HYSocket,giftMsg :GiftMessage)
}

class HYSocket {
    
    weak var delegate : HYSocketDelegate?
    
    fileprivate  var tcpClient : TCPClient
    
    fileprivate var userInfo :UserInfo.Builder = {
        let userInfo = UserInfo.Builder()
        userInfo.name = "why\(arc4random() % 100)"
        userInfo.level = 20
        return userInfo
    }()
    
    
    init(addr:String, port:Int) {
        tcpClient = TCPClient(addr: addr, port: port)
    }

}


extension HYSocket {
    
    func connectServer() -> Bool{
        //设置超时时间
      return  tcpClient.connect(timeout: 5).0
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
                
                //3.处理消息 --回到主线程
                DispatchQueue.main.async {
                     self.handleMsg(type: type, data: msgData)
                }

            }
        }
    }
    
    
    fileprivate func handleMsg (type:Int ,data: Data){
        
        switch type {
        case 0 , 1:
            //parseFrom 反序列化(解析)
            let user =  try! UserInfo.parseFrom(data: data)
            
            type == 0 ? delegate?.socket(self, joinRom: user) : delegate?.socket(self, leaveRom: user)

        case 2:
            let textMsg = try! TextMessage.parseFrom(data: data)
            delegate?.socket(self, textMsg: textMsg)
        case 3:
            let giftMsg = try! GiftMessage.parseFrom(data: data)
            delegate?.socket(self, giftMsg: giftMsg)
            
        default:
            print("未知类型")
        }
        
    }
    
}

extension HYSocket {
    
    ///加入房间 0
    func sendJoinRoom()  {
        
        //1.获取消息的长度
        let msgData = (try! userInfo.build()).data()
        //2.发送消息
        sendMsg(data: msgData, type: 0)
        
    }
    
     ///离开房间 1
    func sendLeaveRoom()  {
        //1.获取消息的长度
        let msgData = (try! userInfo.build()).data()
        //2.发送消息
        sendMsg(data: msgData, type: 1)
    }
    
    ///发送文本消息 2
    func sendTextMsg(message:String)  {
        //1.创建textMsg的类型
        let textMsg = TextMessage.Builder()
        textMsg.user = try! userInfo.build()
        textMsg.text = message
        
        //2.获取对应的data
        let textData = (try! textMsg.build()).data()
        
        //3.发送消息
        sendMsg(data: textData, type: 2)
        
    }
    
    ///礼物消息 3
    func sendGiftMsg(giftname:String,giftURL:String,giftCount:String)  {
        //1.创建giftMsg 
        let giftMsg = GiftMessage.Builder()
        giftMsg.user = try! userInfo.build()
        giftMsg.giftname  = giftname
        giftMsg.giftUrl = giftURL
        giftMsg.giftCount = giftCount
        
        //2.获取对应的data
        let giftData = (try! giftMsg.build()).data()
        
        //3.发送礼物消息
        sendMsg(data: giftData, type: 3)
        
        
    }
    
    func sendMsg(data:Data ,type:Int) {
   
        //1.将消息长度写入到data
        var length = data.count
        let headerData = Data(bytes: &length, count: 4)
        
        //2.消息类型
        var temType = type
        let typeData = Data(bytes: &temType, count: 2)

        //3.发送消息
        //消息格式: 1.消息长度 + 2.消息类型 + 3.真实消息
        let totalData = headerData + typeData + data
  
        tcpClient.send(data: totalData)
    }
    
    //心跳包
    func sendHeartBeat()  {
        
        //获取心跳包中的数据
        let heartString = "I am is a heart"
        let heartData = heartString.data(using: String.Encoding.utf8)!
        
        //2.发送数据
        sendMsg(data: heartData, type: 100)
        
        
    }
    
    
}

