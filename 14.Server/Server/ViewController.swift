//
//  ViewController.swift
//  Server
//
//  Created by Allison on 2017/7/4.
//  Copyright © 2017年 Allison. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var hintLabel: NSTextField!
    
    fileprivate lazy var serverMgr : ServerManager = ServerManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func startServer(_ sender: NSButton) {
        serverMgr.statrRuning()
        hintLabel.stringValue = "服务器已经开启ing"
    }
    
    
    
    @IBAction func stopServer(_ sender: NSButton) {
        serverMgr.stopRuning()
        hintLabel.stringValue = "服务器未开启 "
    }
    
    

}

