//
//  Line.swift
//  TouchTracker
//
//  Created by Xiaoke Zhang on 2017/8/17.
//  Copyright © 2017年 Xiaoke Zhang. All rights reserved.
//

import UIKit

class Line: NSObject, NSCoding, NSCopying {
    var begin: CGPoint
    var end: CGPoint
    var width: Int = 10
    var color: UIColor = UIColor.random()
    
    init?(dict:[String:CGPoint]) {
        if let begin = dict["begin"], let end = dict["end"] {
            self.begin = begin
            self.end = end
        } else {
            return nil
        }
    }
    
    init(begin: CGPoint, end:CGPoint) {
        self.begin = begin
        self.end = end
    }
    
    func encode() -> [String:CGPoint] {
        return ["begin": begin, "end": end]
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.begin = aDecoder.decodeCGPoint(forKey: "begin")
        self.end = aDecoder.decodeCGPoint(forKey: "end")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.begin, forKey: "begin")
        aCoder.encode(self.end, forKey: "end")
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Line(begin: self.begin, end:self.end)
    }
    
    override var description: String {
        return "\(self.begin)-\(self.end) \(self.width)"
    }
}

/**
protocol Encodable {
    var encoded: Decodable? { get }
}
protocol Decodable {
    var decoded: Encodable? { get }
}


extension Line {
    
    class Coding: NSObject, NSCoding {
        let data:Line?
        
        init(data:Line) {
            self.data = data
            super.init()
        }
        
        required init?(coder aDecoder: NSCoder) {
            let begin = aDecoder.decodeCGPoint(forKey: "begin")
            let end = aDecoder.decodeCGPoint(forKey: "end")
            self.data = Line(begin: begin, end:end)
            super.init()
        }
        
        func encode(with aCoder: NSCoder) {
            guard let data = self.data else { return }
            aCoder.encode(data.begin, forKey: "begin")
            aCoder.encode(data.end, forKey: "end")
        }
    
    }
}

extension Line: Encodable {

    var encoded: Decodable? {
        return Coding(data: self)
    }
    
}

extension Line.Coding: Decodable {
    
    var decoded: Encodable? {
        return self.data
    }

}

extension Sequence where Iterator.Element: Encodable {
    var encoded: [Decodable] {
        return self.flatMap({$0.encoded})
    }
}
extension Sequence where Iterator.Element: Decodable {
    var decoded: [Encodable] {
        return self.flatMap({$0.decoded})
    }
}
**/
