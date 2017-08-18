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
        load()
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
            print("load result=\(lines.first)")
            self.finishedLines = lines
        }
        if let colors = NSKeyedUnarchiver.unarchiveObject(withFile: getColorsStoreFile()) as? [String:UIColor] {
            self.lineColors = colors
        }
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        for line in finishedLines {
            if let color = lineColors[line.description] {
                color.set()
            } else {
                UIColor.black.set()
            }
            strokeLine(line)
        }
        UIColor.red.set()
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
                self.lineColors[line.description] = UIColor.random()
                self.finishedLines.append(line)
                self.currentLines[key] = nil
            }
        }
        setNeedsDisplay()
        save()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("\(#function) \(touches.map({$0.location(in: self)}))")
        for t in touches {
            let key = NSValue(nonretainedObject: t)
            self.currentLines[key] = nil
        }
        setNeedsDisplay()
        save()
    }
    
    
}
