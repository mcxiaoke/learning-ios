//
//  CollectionEx.swift
//  Homepwner
//
//  Created by Xiaoke Zhang on 2017/8/16.
//  Copyright © 2017年 Xiaoke Zhang. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    
    static func -= (lhs: inout Array, rhs: Element) {
        lhs.remove(object: rhs)
    }
    
    static func += (lhs: inout Array, rhs: Element) {
        lhs.append(rhs)
    }
    
    @discardableResult mutating func remove(object: Element) -> Bool {
        if let index = index(of: object) {
            self.remove(at: index)
            return true
        }
        return false
    }
    
    @discardableResult mutating func remove(where predicate: (Array.Iterator.Element) -> Bool) -> Bool {
        if let index = self.index(where: { (element) -> Bool in
            return predicate(element)
        }) {
            self.remove(at: index)
            return true
        }
        return false
    }
    
}
