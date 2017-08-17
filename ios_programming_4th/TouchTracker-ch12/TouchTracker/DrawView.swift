//
//  DrawView.swift
//  TouchTracker
//
//  Created by Xiaoke Zhang on 2017/8/17.
//  Copyright © 2017年 Xiaoke Zhang. All rights reserved.
//

import UIKit

class DrawView: UIView {
    var currentLines:[NSValue:Line] = [:]
    var finishedLines:[Line] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        self.isMultipleTouchEnabled = true
        self.backgroundColor = UIColor.gray
    }
    
    override func draw(_ rect: CGRect) {
        UIColor.black.set()
        for line in finishedLines {
            strokeLine(line)
        }
        UIColor.blue.set()
        for line in currentLines.values {
            strokeLine(line)
        }
    }
    
    func strokeLine(_ line: Line) {
        let bp = UIBezierPath()
        bp.lineWidth = 10
        bp.lineCapStyle = .round
        bp.move(to: line.begin)
        bp.addLine(to: line.end)
        bp.stroke()
    }
    
    // MARK: TouchEvent
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("\(#function) \(touches.map({$0.location(in: self)}))")
        for t in touches {
            let p = t.location(in: self)
            let line = Line(begin: p, end: p)
            // using memory address
            let key = NSValue(nonretainedObject: t)
            self.currentLines[key] = line
        }
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("\(#function) \(touches.map({$0.location(in: self)}))")
        for t in touches {
            let key = NSValue(nonretainedObject: t)
            if var line = self.currentLines[key] {
                line.end = t.location(in: self)
                self.currentLines[key] = line
            }
        }
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("\(#function) \(touches.map({$0.location(in: self)}))")
        for t in touches {
            let key = NSValue(nonretainedObject: t)
            if let line = self.currentLines[key] {
                self.finishedLines.append(line)
                self.currentLines[key] = nil
            }
        }
        setNeedsDisplay()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("\(#function) \(touches.map({$0.location(in: self)}))")
        for t in touches {
            let key = NSValue(nonretainedObject: t)
            self.currentLines[key] = nil
        }
        setNeedsDisplay()
    }
    
    
}
