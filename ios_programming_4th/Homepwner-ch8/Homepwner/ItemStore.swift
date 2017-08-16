//
//  ItemStore.swift
//  Homepwner
//
//  Created by Xiaoke Zhang on 2017/8/16.
//  Copyright © 2017年 Xiaoke Zhang. All rights reserved.
//

import Foundation

class ItemStore: AnyObject {
    static let shared = ItemStore()
    
    var allItems = [Item]()
    
    func createItem() -> Item {
        let newItem =  Item.randomItem()
        allItems.append(newItem)
        return newItem
    }
}
