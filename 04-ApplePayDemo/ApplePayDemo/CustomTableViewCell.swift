//
//  CustomTableViewCell.swift
//  ApplePayDemo
//
//  Created by Allison on 2017/4/28.
//  Copyright © 2017年 Allison. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLab: UILabel!//标题
    
    @IBOutlet weak var subTitleLab: UILabel!//副标题

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
