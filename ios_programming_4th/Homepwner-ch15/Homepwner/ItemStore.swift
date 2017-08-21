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
        allItems += newItem
        return newItem
    }
    
    func move(fromIndex:Int, toIndex:Int) {
        if fromIndex == toIndex {
            return
        }
        let item = allItems[fromIndex]
        allItems -= item
        allItems.insert(item, at: toIndex)
    }
    
    func replace(newItem: Item) {
        if let index = allItems.index(of: newItem) {
            allItems[index] = newItem
        }
    }
}
