//
//  DraggableItemView.swift
//  DragItemAround
//
//  Created by mcxiaoke on 16/6/8.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

class DraggableItemView: NSView {
  
  var itemSize = NSSize(width: 40.0, height: 40.0) {
    didSet {
      self.setNeedsDisplayInRect(self.calculatedItemBounds())
    }
  }
  var backgroundColor = NSColor.whiteColor(){
    didSet {
      self.setNeedsDisplayInRect(self.calculatedItemBounds())
    }
  }
  var itemColor = NSColor.redColor() {
    didSet {
      self.setNeedsDisplayInRect(self.calculatedItemBounds())
    }
  }
  var location = NSPoint.zero {
    willSet {
      self.setNeedsDisplayInRect(self.calculatedItemBounds())
    }
    didSet {
      self.setNeedsDisplayInRect(self.calculatedItemBounds())
      self.window?.invalidateCursorRectsForView(self)
    }
  }
  var dragging:Bool = false
  var lastDragPoint:NSPoint = NSPoint.zero
  

  override init(frame frameRect: NSRect) {
    super.init(frame: frameRect)
    self.setItemPropertiesToDefault()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.setItemPropertiesToDefault()
  }
  
  deinit {
    // nothing
  }
  
  func setItemPropertiesToDefault(){
    self.itemColor = NSColor.redColor()
    self.backgroundColor = NSColor.whiteColor()
    self.location = NSPoint.zero
  }
  
  func calculatedItemBounds() -> NSRect {
    return NSRect(origin: self.location, size: self.itemSize)
  }
  
  override var opaque: Bool {
    return self.backgroundColor.alphaComponent >= 1.0
  }
  
  override var acceptsFirstResponder: Bool{
    return true
  }
  
  override func resetCursorRects() {
    self.discardCursorRects()
    let clippedItemBounds = NSIntersectionRect(self.visibleRect, self.calculatedItemBounds())
    if !NSIsEmptyRect(clippedItemBounds) {
      self.addCursorRect(clippedItemBounds, cursor: NSCursor.openHandCursor())
    }
  }
  
  override func changeColor(sender: AnyObject?) {
    if let colorPanel = sender as? NSColorPanel {
      self.itemColor = colorPanel.color
    }
  }
  
  override func drawRect(dirtyRect: NSRect) {
    self.backgroundColor.set()
    NSBezierPath.fillRect(dirtyRect)
    self.itemColor.set()
    NSBezierPath.fillRect(self.calculatedItemBounds())
  }
  
  override func moveUp(sender: AnyObject?) {
    self.offsetLocationBy(0, y: 10.0)
    self.window?.invalidateCursorRectsForView(self)
  }
  
  override func moveDown(sender: AnyObject?) {
    self.offsetLocationBy(0, y: -10.0)
    self.window?.invalidateCursorRectsForView(self)
  }
  
  override func moveLeft(sender: AnyObject?) {
    self.offsetLocationBy(-10.0, y: 0)
    self.window?.invalidateCursorRectsForView(self)
  }
  
  override func moveRight(sender: AnyObject?) {
    self.offsetLocationBy(10.0, y: 0)
    self.window?.invalidateCursorRectsForView(self)
  }
  
  override func keyDown(theEvent: NSEvent) {
    guard let characters = theEvent.charactersIgnoringModifiers else {
      super.keyDown(theEvent)
      return
    }
    switch characters {
    case "r":
      self.setItemPropertiesToDefault()
    case "g":
      self.itemColor = NSColor.greenColor()
    case "y":
      self.itemColor = NSColor.yellowColor()
    case "b":
      self.itemColor = NSColor.blueColor()
    default:
      super.keyDown(theEvent)
    }
  }
  
  override func mouseDown(theEvent: NSEvent) {
    let point = self.convertPoint(theEvent.locationInWindow, fromView: nil)
    let hit = self.isPointInItem(point)
    if hit {
      dragging = true
      lastDragPoint = point
      NSCursor.closedHandCursor().push()
    }
  }
  
  override func mouseUp(theEvent: NSEvent) {
    dragging = false
    NSCursor.pop()
    self.window?.invalidateCursorRectsForView(self)
  }
  
  override func mouseDragged(theEvent: NSEvent) {
    if dragging {
      let newPoint = self.convertPoint(theEvent.locationInWindow, fromView: nil)
      let newX = newPoint.x - lastDragPoint.x
      let newY = newPoint.y - lastDragPoint.y
      self.offsetLocationBy(newX, y: newY)
      lastDragPoint = newPoint
      self.autoscroll(theEvent)
    }
  }
  
  func offsetLocationBy(x:CGFloat, y:CGFloat){
    self.setNeedsDisplayInRect(self.calculatedItemBounds())
    let invertDeltaY:CGFloat = self.flipped ? -1 : 1
    location.x += x
    location.y += y * invertDeltaY
    self.setNeedsDisplayInRect(self.calculatedItemBounds())
  }
  
  func isPointInItem(point:NSPoint) -> Bool {
    return NSPointInRect(point, self.calculatedItemBounds())
  }

  
  
}
