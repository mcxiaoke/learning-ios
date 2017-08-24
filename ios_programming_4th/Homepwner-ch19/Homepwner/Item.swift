//
//  Item.swift
//  Homepwner
//
//  Created by Xiaoke Zhang on 2017/8/16.
//  Copyright © 2017年 Xiaoke Zhang. All rights reserved.
//

import Foundation

class Item : NSObject, NSCoding, NSCopying{
    
    internal struct Keys {
        static let itemName = "itemName"
        static let serialNumber = "serialNumber"
        static let valueInDollars = "valueInDollars"
        static let key = "key"
        static let dateCreated = "dateCreated"
    }
    
    var itemName:String
    var serialNumber:String
    var valueInDollars:Int
    var key = UUID().uuidString
    var dateCreated:Date = Date()
    
    override var description:String {
        return "\(itemName) (\(serialNumber)) $\(valueInDollars)"
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
    
    init(itemName: String, serialNumber: String, valueInDollars: Int) {
        self.itemName = itemName
        self.serialNumber = serialNumber
        self.valueInDollars = valueInDollars
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.itemName = aDecoder.decodeObject(forKey: Keys.itemName) as! String
        self.serialNumber = aDecoder.decodeObject(forKey: Keys.serialNumber) as! String
        self.valueInDollars = aDecoder.decodeInteger(forKey: Keys.valueInDollars)
        self.key = aDecoder.decodeObject(forKey: Keys.key) as! String
        let tm = aDecoder.decodeDouble(forKey: Keys.dateCreated)
        self.dateCreated = Date(timeIntervalSince1970: tm)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.itemName, forKey: Keys.itemName)
        aCoder.encode(self.serialNumber, forKey: Keys.serialNumber)
        aCoder.encode(self.valueInDollars, forKey: Keys.valueInDollars)
        aCoder.encode(self.key, forKey: Keys.key)
        aCoder.encode(self.dateCreated.timeIntervalSince1970, forKey: Keys.dateCreated)
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Item.init(itemName: self.itemName,
                         serialNumber: self.serialNumber,
                         valueInDollars: self.valueInDollars)
    }
    
}
