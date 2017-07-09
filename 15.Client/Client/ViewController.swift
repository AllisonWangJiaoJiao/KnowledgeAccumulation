//
//  ViewController.swift
//  Client
//
//  Created by Allison on 2017/7/4.
//  Copyright © 2017年 Allison. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate lazy var socket : HYSocket = HYSocket.init(addr: "0.0.0.0", port: 7878)

    override func viewDidLoad() {
        super.viewDidLoad()

        if socket.connectServer() {
            print("连接上服务器")
        }
    
    }
    
    /*
     礼物
     广播
     进入房间
     离开房间
     文本
     */
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //1.获取消息的长度
//        let message = "你好啊, 王小二....."
//        let data = message.data(using: String.Encoding.utf8)!
//        var length = data.count
//        print(length)
        
        let userInfo = UserInfo.Builder()
        userInfo.name = "why\(arc4random())"
        userInfo.level = 20
        let msgData = (try! userInfo.build()).data()
        
        
        //2.将消息长度写入到data
        var length = msgData.count
        let headerData = Data(bytes: &length, count: 4)
       
        
        //3.消息类型
        var type = 2
        let typeData = Data(bytes: &type, count: 2)
        
        
        
        //3.发送消息
        //消息格式: 1.消息长度 + 2.消息类型 + 3.真实消息
        let totalData = headerData + typeData + msgData
        socket.sendMsg(data: totalData)
    }

  
}

