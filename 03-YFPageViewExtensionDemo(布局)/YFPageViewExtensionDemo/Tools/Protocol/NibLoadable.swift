//
//  NibLoadable.swift
//  05-UIView从xib中加载(POP)
//
//  Created by 小码哥 on 2016/12/10.
//  Copyright © 2016年 xmg. All rights reserved.
//

import UIKit

protocol NibLoadable {
}

extension NibLoadable where Self : UIView {
    static func loadFromNib(_ nibname : String? = nil) -> Self {
        let loadName = nibname == nil ? "\(self)" : nibname!
        return Bundle.main.loadNibNamed(loadName, owner: nil, options: nil)?.first as! Self
    }
}
