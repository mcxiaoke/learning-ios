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
    
    var archivePath: URL {
        let documents = try! FileManager.default.url(for: .documentDirectory,
                                                     in: .userDomainMask,
                                                     appropriateFor: nil,
                                                     create: true)
        return documents.appendingPathComponent("items.archive")
    }
    
    func createItem() -> Item {
        let newItem = Item(itemName:"Item",
                           serialNumber:"",
                           valueInDollars: 0)
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
    
    func save() -> Bool {
        return NSKeyedArchiver.archiveRootObject(allItems, toFile: archivePath.path)
    }
    
    func load() -> Bool {
        let path = archivePath.path
        guard FileManager.default.fileExists(atPath: path) else { return false }
        if let items = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? [Item] {
            self.allItems = items
            return true
        }
        return false
    }
}
