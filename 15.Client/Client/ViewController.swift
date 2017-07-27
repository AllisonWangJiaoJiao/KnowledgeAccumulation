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
    
    fileprivate var timer : Timer!

    override func viewDidLoad() {
        super.viewDidLoad()

        if socket.connectServer() {
            print("连接上服务器")
            socket.startReadMsg()
//            socket.delegate = self
            
            
            timer = Timer(fireAt: Date(), interval: 9, target: self, selector: #selector(sendHeartBeat), userInfo: nil, repeats: true)
            RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
            
            
        }
   
        
    }
    
    deinit {
        timer.invalidate()
        timer = nil
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    /*
     进入房间 =0
     离开房间 =1
     文本 =2
     礼物 =3
     */
    
    
    @IBAction func joinRoom(_ sender: UIButton) {
        socket.sendJoinRoom()
    }
    
    @IBAction func leaveRoom(_ sender: UIButton) {
        socket.sendLeaveRoom()
    }
    
    @IBAction func sendText(_ sender: UIButton) {
        socket.sendTextMsg(message: "这是一个文本消息")
    }

    @IBAction func sendGift(_ sender: UIButton) {
        socket.sendGiftMsg(giftname: "火锅", giftURL: "http://www.baidu.com", giftCount: "100")
    }

}


extension ViewController {
    
    @objc fileprivate func sendHeartBeat() {
        
        socket.sendHeartBeat()
        
    }
}




