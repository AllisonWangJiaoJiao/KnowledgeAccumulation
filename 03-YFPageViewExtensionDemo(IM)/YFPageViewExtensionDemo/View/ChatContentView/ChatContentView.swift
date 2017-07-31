//
//  ChatContentView.swift
//  YFPageViewExtensionDemo
//
//  Created by Allison on 2017/7/31.
//  Copyright © 2017年 Allison. All rights reserved.
//

import UIKit

private let kChatContentCellID = "kChatContentCellID"

class ChatContentView: UIView,NibLoadable {

    @IBOutlet weak var tableView: UITableView!
 
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: kChatContentCellID)
    }

}

extension ChatContentView:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kChatContentCellID, for: indexPath)
        cell.textLabel?.text = "测试数据:\(indexPath.row)"
        return cell
        
    }
}
