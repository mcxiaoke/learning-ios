//
//  ViewController.swift
//  Homepwner
//
//  Created by Xiaoke Zhang on 2017/8/16.
//  Copyright © 2017年 Xiaoke Zhang. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
    }
    
    init() {
        super.init(style: .plain)
        for _ in 0..<10 {
            let _ = ItemStore.shared.createItem()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "UITableViewCell")
//        let footer = UILabel(frame:CGRect(x:0, y:0, width:200, height:60))
//        footer.textAlignment = .center
//        footer.text = "No more items."
//        self.tableView.tableFooterView = footer
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemStore.shared.allItems.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        if indexPath.row == ItemStore.shared.allItems.count {
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.text = "No more items."
        } else{
            let item = ItemStore.shared.allItems[indexPath.row]
            cell.textLabel?.textAlignment = .left
            cell.textLabel?.text = item.description
        }
        return cell
    }


}

