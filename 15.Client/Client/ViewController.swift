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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let message = "你好啊, 李银河"
        let data = message.data(using: String.Encoding.utf8)
        print(data?.count)
        
        socket.sendMsg(str: message)
    }

  
}

