//
//  Item.swift
//  Homepwner
//
//  Created by Xiaoke Zhang on 2017/8/16.
//  Copyright © 2017年 Xiaoke Zhang. All rights reserved.
//

import Foundation

struct Item : Equatable{
    var itemName:String
    var serialNumber:String
    var valueInDollars:Int
    let key = UUID().uuidString
    let dateCreated:Date = Date()
    
    var description:String {
        return "\(itemName) (\(serialNumber)) Worth \(valueInDollars), recorded on \(dateCreated)"
    }
    
    public static func ==(lhs: Item, rhs: Item) -> Bool {
        return lhs.key == rhs.key
    }
    
    static func randomItem() -> Item {
        let adjectives = ["Fluffy", "Rusty", "Shiny"]
        let nouns = ["Bear", "Spork", "Mac"]
        let ai = Int(arc4random()) % adjectives.count
        let ni = Int(arc4random()) % nouns.count
        let randomName = "\(adjectives[ai]) \(nouns[ni])"
        let randomValue = Int(arc4random_uniform(100))
        let s0 = "0\(arc4random_uniform(10))"
        let s1 = "A\(arc4random_uniform(26))"
        let s2 = "0\(arc4random_uniform(10))"
        let randomSerialNumber = "\(s0)-\(s1)-\(s2)"
        return Item(itemName:randomName,
                    serialNumber:randomSerialNumber,
                    valueInDollars: randomValue)
    }
    
}
