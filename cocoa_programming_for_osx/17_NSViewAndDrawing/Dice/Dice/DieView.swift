//
//  DieView.swift
//  Dice
//
//  Created by mcxiaoke on 16/5/5.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

class DieView: NSView {
  
  var intValue : Int? = 3 {
    didSet {
      needsDisplay = true
    }
  }
  
  override var intrinsicContentSize: NSSize {
    return NSSize(width: 40, height: 40)
  }
  
  override func drawRect(dirtyRect: NSRect) {
    let bgColor = NSColor.lightGrayColor()
    bgColor.set()
    NSBezierPath.fillRect(bounds)
//    NSColor.greenColor().set()
//    let path = NSBezierPath()
//    path.moveToPoint(NSPoint(x: 0, y: 0))
//    path.lineToPoint(NSPoint(x: bounds.width, y: bounds.height))
//    path.stroke()
    drawDieWithSize(bounds.size)
  }
  
  func metricsForSize(size:CGSize) -> (edgeLength: CGFloat, dieFrame: CGRect) {
    let edgeLength = min(size.width, size.height)
    let padding = edgeLength / 10.0
    // at center
    let ox = (size.width - edgeLength )/2
    let oy = (size.height - edgeLength)/2
    let drawingBounds = CGRect(x: ox, y: oy, width: edgeLength, height: edgeLength)
    let dieFrame = drawingBounds.insetBy(dx: padding, dy: padding)
    return (edgeLength, dieFrame)
  }
  
  func drawDieWithSize(size:CGSize) {
    if let intValue = intValue {
      let (edgeLength, dieFrame) = metricsForSize(size)
      let cornerRadius:CGFloat = edgeLength / 5.0
      let dotRadius = edgeLength / 12.0
      let dotFrame = dieFrame.insetBy(dx: dotRadius * 2.5, dy: dotRadius * 2.5)
      
      NSGraphicsContext.saveGraphicsState()
      
      let shadow = NSShadow()
      shadow.shadowOffset = NSSize(width: 0, height: -1)
      shadow.shadowBlurRadius = edgeLength / 20
      shadow.set()
      
      NSColor.whiteColor().set()
      NSBezierPath(roundedRect: dieFrame, xRadius: cornerRadius, yRadius: cornerRadius).fill()
      
      NSGraphicsContext.restoreGraphicsState()
      
      NSColor.blackColor().set()
      func drawDot(u: CGFloat, v:CGFloat) {
        let dotOrigin = CGPoint(x: dotFrame.minX + dotFrame.width * u,
                                y: dotFrame.minY + dotFrame.height * v)
        let dotRect = CGRect(origin: dotOrigin, size: CGSizeZero).insetBy(dx: -dotRadius, dy: -dotRadius)
        NSBezierPath(ovalInRect: dotRect).fill()
      }
      
      if (1...6).indexOf(intValue) != nil {
        if [1,3,5].indexOf(intValue) != nil {
          drawDot(0.5, v: 0.5)
        }
        if (2...6).indexOf(intValue) != nil {
          drawDot(0, v: 1)
          drawDot(1, v: 0)
        }
        if (4...6).indexOf(intValue) != nil {
          drawDot(1, v: 1)
          drawDot(0, v: 0)
        }
        if intValue == 6 {
          drawDot(0, v: 0.5)
          drawDot(1, v: 0.5)
        }
      }
    }

  }
  
}
