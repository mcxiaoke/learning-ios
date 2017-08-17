//
//  Extensions.swift
//  TouchTracker
//
//  Created by Xiaoke Zhang on 2017/8/17.
//  Copyright © 2017年 Xiaoke Zhang. All rights reserved.
//

import UIKit

extension CGPoint : Hashable {
    func distance(point: CGPoint) -> Float {
        let dx = Float(x - point.x)
        let dy = Float(y - point.y)
        return sqrt((dx * dx) + (dy * dy))
    }
    public var hashValue: Int {
        // iOS Swift Game Development Cookbook
        // https://books.google.se/books?id=QQY_CQAAQBAJ&pg=PA304&lpg=PA304&dq=swift+CGpoint+hashvalue&source=bl&ots=1hp2Fph274&sig=LvT36RXAmNcr8Ethwrmpt1ynMjY&hl=sv&sa=X&ved=0CCoQ6AEwAWoVChMIu9mc4IrnxgIVxXxyCh3CSwSU#v=onepage&q=swift%20CGpoint%20hashvalue&f=false
        return x.hashValue << 32 ^ y.hashValue
    }
}

func ==(lhs: CGPoint, rhs: CGPoint) -> Bool {
    // return lhs.distance(point: rhs) < 0.000001
    //CGPointEqualToPoint(lhs, rhs)
    return lhs.hashValue == rhs.hashValue
}
