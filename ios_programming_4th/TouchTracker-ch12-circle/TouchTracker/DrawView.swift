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
    var lineColors:[String:UIColor] = [:]
    
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
//        load()
    }
    
    func getLinesStoreFile() -> String {
        let fileDir = try! FileManager.default.url(for: .documentDirectory,
                                                   in: .userDomainMask,
                                                   appropriateFor: nil,
                                                   create: true)
        return fileDir.appendingPathComponent("finishedLines.dat").path
    }
    
    func getColorsStoreFile() -> String {
        let fileDir = try! FileManager.default.url(for: .documentDirectory,
                                                   in: .userDomainMask,
                                                   appropriateFor: nil,
                                                   create: true)
        return fileDir.appendingPathComponent("finishedLineColors.dat").path
    }
    
    func save() {
        let ret = NSKeyedArchiver.archiveRootObject(self.finishedLines, toFile: getLinesStoreFile())
        print("save result=\(ret)")
        let _ = NSKeyedArchiver.archiveRootObject(self.lineColors, toFile: getColorsStoreFile())
    }
    
    func load() {
        if let lines = NSKeyedUnarchiver.unarchiveObject(withFile: getLinesStoreFile()) as? [Line] {
            self.finishedLines = lines
        }
        if let colors = NSKeyedUnarchiver.unarchiveObject(withFile: getColorsStoreFile()) as? [String:UIColor] {
            self.lineColors = colors
        }
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        for index in stride(from: 0, to: finishedLines.count-1, by: 2) {
            if let color = lineColors[finishedLines[index].description] {
                color.set()
            } else {
                UIColor.black.set()
            }
            strokeCircle(a: finishedLines[index], b: finishedLines[index+1])
        }
        if currentLines.count == 2 {
            UIColor.blue.set()
            let points = Array(currentLines.values)
            strokeCircle(a: points[0], b: points[1])
            return
        }
    }
    
    func strokeCircle(a: Line, b: Line) {
        let bp = UIBezierPath()
        bp.lineWidth = 5
        bp.lineCapStyle = .round
        let x1 = a.end.x
        let y1 = a.end.y
        let x2 = b.end.x
        let y2 = b.end.y
        let center = CGPoint(x: (x1+x2)/2, y: (y1+y2)/2)
        let radius = sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2))/2
//        print("strokeCircle a=\(a) b=\(b)")
//        print("strokeCircle center=\(center) radius=\(radius)")
        bp.addArc(withCenter: center, radius: radius, startAngle: 0, endAngle: 360, clockwise: true)
        bp.stroke()
    }
    
    // MARK: TouchEvent
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("\(#function) \(touches.map({$0.location(in: self)}))")
        if touches.count != 2 { return }
        for t in touches {
            let p = t.location(in: self)
            let line = Line(begin: p, end: p)
            let key = NSValue(nonretainedObject: t)
            self.currentLines[key] = line
        }
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let key = NSValue(nonretainedObject: t)
            if let line = self.currentLines[key] {
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
                self.lineColors[line.description] = UIColor.random()
                self.finishedLines.append(line)
                self.currentLines[key] = nil
            }
        }
        setNeedsDisplay()
//        save()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let key = NSValue(nonretainedObject: t)
            self.currentLines[key] = nil
        }
        setNeedsDisplay()
//        save()
    }
    
    
}
