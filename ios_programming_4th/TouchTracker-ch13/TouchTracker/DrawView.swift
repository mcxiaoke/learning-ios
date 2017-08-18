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
    var lineColors:[Int:UIColor] = [:]
    weak var selectedLine:Line?
    
    var moveRecongnizer: UIPanGestureRecognizer?
    
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
        self.backgroundColor = UIColor.white
//        load()
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTap(gs:)))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delaysTouchesBegan = true
        self.addGestureRecognizer(doubleTap)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(singleTap(gs:)))
        singleTap.numberOfTapsRequired = 1
        singleTap.require(toFail: doubleTap)
        singleTap.delaysTouchesBegan = true
        self.addGestureRecognizer(singleTap)
        
        let longPress = UILongPressGestureRecognizer.init(target: self, action: #selector(longPress(gs:)))
        self.addGestureRecognizer(longPress)
        
        let move = UIPanGestureRecognizer(target: self, action: #selector(move(gs:)))
        move.delegate = self
        move.cancelsTouchesInView = false
        self.moveRecongnizer = move
        self.addGestureRecognizer(move)
    }
    
    func longPress(gs:UIGestureRecognizer) {
        switch gs.state {
        case .began:
            print("longPress began")
            let point = gs.location(in: self)
            self.selectedLine = lineAt(point: point)
            if let _ = self.selectedLine {
                self.currentLines.removeAll()
            }
        case .ended:
            print("longPress end")
            self.selectedLine = nil
        default:
            break
        }
        setNeedsDisplay()
    }
    
    func singleTap(gs: UIGestureRecognizer) {
        print("singleTap")
        let point = gs.location(in: self)
        self.selectedLine = lineAt(point: point)
//        setNeedsDisplay()
        if let _ = self.selectedLine {
            self.becomeFirstResponder()
            let menu = UIMenuController.shared
            let deleteItem = UIMenuItem.init(title: "Delete", action: #selector(deleteLine(_:)))
            menu.menuItems = [deleteItem]
            menu.setTargetRect(CGRect(x: point.x, y:point.y, width: 2, height: 2), in: self)
            menu.isMenuVisible = true
        } else {
            UIMenuController.shared.isMenuVisible = false
        }
    }
    
    func doubleTap(gs: UIGestureRecognizer) {
        print("doubleTap")
        self.currentLines.removeAll()
        self.finishedLines.removeAll()
        setNeedsDisplay()
    }
    
    func move(gs: UIPanGestureRecognizer) {
//        print("move")
        guard let line = self.selectedLine else { return }
        switch gs.state {
        case .changed:
            let translation = gs.translation(in: self)
            line.begin.x += translation.x
            line.begin.y += translation.y
            line.end.x += translation.x
            line.end.y += translation.y
            gs.setTranslation(CGPoint.zero, in: self)
            setNeedsDisplay()
        default:
            break
        }
    }
    
    func deleteLine(_ id: Any?) {
        if let line = self.selectedLine {
            self.finishedLines.remove(object: line)
            setNeedsDisplay()
        }
    }
    
    func lineAt(point: CGPoint) -> Line? {
        for line in self.finishedLines {
            let start = line.begin
            let end = line.end
            var t = CGFloat(0.0)
            while t <= 1.0 {
                let x = start.x + t * (end.x - start.x)
                let y = start.y + t * (end.y - start.y)
                if hypot(x - point.x, y - point.y) < 20.0 {
                    print("found line: \(line)")
                    return line
                }
                t += 0.05
            }
        }
        return nil
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
        if let colors = NSKeyedUnarchiver.unarchiveObject(withFile: getColorsStoreFile()) as? [Int:UIColor] {
            self.lineColors = colors
        }
        setNeedsDisplay()
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func draw(_ rect: CGRect) {
        for line in finishedLines {
            if let color = lineColors[line.hashValue] {
                color.set()
            } else {
                UIColor.black.set()
            }
            strokeLine(line)
        }
        
//        if let line = self.selectedLine {
//            UIColor.green.set()
//            strokeLine(line)
//        }
        
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
//        print("\(#function) \(touches.map({$0.location(in: self)}))")
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
                self.lineColors[line.hashValue] = UIColor.random()
                self.finishedLines.append(line)
                self.currentLines[key] = nil
            }
        }
        setNeedsDisplay()
//        save()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("\(#function) \(touches.map({$0.location(in: self)}))")
        for t in touches {
            let key = NSValue(nonretainedObject: t)
            self.currentLines[key] = nil
        }
        setNeedsDisplay()
//        save()
    }
    
}

extension DrawView: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return gestureRecognizer == self.moveRecongnizer
    }
    
}
