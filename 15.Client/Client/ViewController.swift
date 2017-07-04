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

  
}

