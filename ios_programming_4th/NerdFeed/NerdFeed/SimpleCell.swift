//
//  SimpleCell.swift
//  NerdFeed
//
//  Created by Xiaoke Zhang on 2017/9/6.
//  Copyright © 2017年 Xiaoke Zhang. All rights reserved.
//

import UIKit

class SimpleCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    init() {
        super.init(style: .subtitle, reuseIdentifier: "Cell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
