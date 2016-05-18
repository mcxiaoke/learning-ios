//
//  DieView.swift
//  Dice
//
//  Created by mcxiaoke on 16/5/5.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

@IBDesignable class DieView: NSView, NSDraggingSource {
  
  var rollsRemaining: Int = 0
  
  var mouseDownEvent: NSEvent?
  
  var numberOfTimesToRoll: Int = 10
  
  var color: NSColor = NSColor.whiteColor() {
    didSet {
      needsDisplay = true
    }
  }
  
  var highlightFroDragging: Bool = false {
    didSet {
      needsDisplay = true
    }
  }
  
  var highlighted: Bool = false {
    
    didSet {
      needsDisplay = true
    }
  }

  
  var intValue : Int? = 5 {
    
    didSet {
      needsDisplay = true
    }
  }
  
  var pressed: Bool = false {
    didSet {
      needsDisplay = true
    }
  }
  
  func setup(){
    self.registerForDraggedTypes([NSPasteboardTypeString])
    randomize()
  }
  
  override init(frame frameRect: NSRect) {
    super.init(frame: frameRect)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  override var intrinsicContentSize: NSSize {
    return NSSize(width: 40, height: 40)
  }
  
  override var focusRingMaskBounds: NSRect {
    return bounds
  }
  
  override func drawFocusRingMask() {
    NSBezierPath.fillRect(bounds)
  }
  
  override var acceptsFirstResponder: Bool {
    return true
  }
  
  override func becomeFirstResponder() -> Bool {
    return true
  }
  
  override func resignFirstResponder() -> Bool {
    return true
  }
  
  override func keyDown(theEvent: NSEvent) {
    interpretKeyEvents([theEvent])
  }
  
  override func insertTab(sender: AnyObject?) {
    window?.selectNextKeyView(sender)
  }
  
  override func insertBacktab(sender: AnyObject?) {
    window?.selectPreviousKeyView(sender)
  }
  
  override func insertText(insertString: AnyObject) {
    let text = insertString as! String
    if let number = Int(text) {
      intValue = number
    }
  }
  
  override func mouseEntered(theEvent: NSEvent) {
    highlighted = true
    window?.makeFirstResponder(self)
  }
  
  override func mouseExited(theEvent: NSEvent) {
    highlighted = false
  }
  
  override func viewDidMoveToWindow() {
    window?.acceptsMouseMovedEvents = true
    // let options: NSTrackingAreaOptions = .MouseEnteredAndExited | .ActiveAlways | .InVisibleRect
    // Swift 2 fix
    // http://stackoverflow.com/questions/36560189/no-candidates-produce-the-expected-contextual-result-type-nstextstorageedit
     let options: NSTrackingAreaOptions = [.MouseEnteredAndExited, .ActiveAlways, .InVisibleRect ]
    let trackingArea = NSTrackingArea(rect: NSRect(), options: options, owner: self, userInfo: nil)
    addTrackingArea(trackingArea)
  }
  
  func randomize() {
    intValue = Int(arc4random_uniform(5)+1)
  }
  
  func roll() {
    rollsRemaining = numberOfTimesToRoll
    NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: #selector(rollTick), userInfo: nil, repeats: true)
    window?.makeFirstResponder(nil)
  }
  
  func rollTick(sender:NSTimer){
    let lastIntValue = intValue
    while intValue == lastIntValue {
      randomize()
    }
    rollsRemaining -= 1
    if rollsRemaining == 0 {
      sender.invalidate()
      window?.makeFirstResponder(self)
    }
  }
  
  override func mouseDown(theEvent: NSEvent) {
    mouseDownEvent = theEvent
    let pointInView = convertPoint(theEvent.locationInWindow, fromView: nil)
//    let dieFrame = metricsForSize(bounds.size).dieFrame
//    pressed = dieFrame.contains(pointInView)
    pressed = diePathWithSize(bounds.size).containsPoint(pointInView)
  }
  
  override func mouseDragged(theEvent: NSEvent) {
//    Swift.print("mouse dragged, location: \(theEvent.locationInWindow)")
    let downPoint = mouseDownEvent!.locationInWindow
    let dragPoint = theEvent.locationInWindow
    let distanceDragged = hypot(downPoint.x - dragPoint.x, downPoint.y - dragPoint.y)
    if distanceDragged < 3 { return }
    
    pressed = false
    
    if let intValue = intValue {
      let imageSize = bounds.size
      let image = NSImage(size: imageSize, flipped: false) { (imageBounds) in
        self.drawDieWithSize(imageBounds.size)
        return true
      }
      
      let draggingFrameOrigin = convertPoint(downPoint, fromView: nil)
      let draggingFrame = NSRect(origin: draggingFrameOrigin, size: imageSize)
        .offsetBy(dx: -imageSize.width/2, dy: -imageSize.height/2)
      
      let pbItem = NSPasteboardItem()
      let bitmap = self.bitmapImageRepForCachingDisplayInRect(self.bounds)!
      self.cacheDisplayInRect(self.bounds, toBitmapImageRep: bitmap)
      pbItem.setString("\(intValue)", forType: NSPasteboardTypeString)
      pbItem.setData(bitmap.representationUsingType(.NSPNGFileType, properties: [:]), forType: NSPasteboardTypePNG)
      let item = NSDraggingItem(pasteboardWriter: pbItem)
      item.draggingFrame = draggingFrame
      item.imageComponentsProvider = {
        let component = NSDraggingImageComponent(key: NSDraggingImageComponentIconKey)
        component.contents = image
        component.frame = NSRect(origin: NSPoint(), size: imageSize)
        return [component]
      }
      
      beginDraggingSessionWithItems([item], event: mouseDownEvent!, source: self)
    }
    
  }
  
  override func mouseUp(theEvent: NSEvent) {
//    Swift.print("mouse up click count: \(theEvent.clickCount)")
    if theEvent.clickCount == 2 {
      roll()
    }
    pressed = false
  }
  
  
  // dragging source
  func draggingSession(session: NSDraggingSession, sourceOperationMaskForDraggingContext context: NSDraggingContext) -> NSDragOperation {
    return [.Copy, .Delete]
  }
  
  func draggingSession(session: NSDraggingSession, endedAtPoint screenPoint: NSPoint, operation: NSDragOperation) {
    if operation == .Delete {
      intValue = nil
    }
  }
  
  // dragging destination
  override func draggingEntered(sender: NSDraggingInfo) -> NSDragOperation {
    if sender.draggingSource() as? DieView == self {
      return .None
    }
    highlightFroDragging = true
    return sender.draggingSourceOperationMask()
  }
  
  override func draggingUpdated(sender: NSDraggingInfo) -> NSDragOperation {
    Swift.print("operation mask = \(sender.draggingSourceOperationMask().rawValue)")
    if sender.draggingSource() === self {
      return .None
    }
    return [.Copy,.Delete]
  }
  
  override func draggingExited(sender: NSDraggingInfo?) {
    highlightFroDragging = false
  }
  
  override func performDragOperation(sender: NSDraggingInfo) -> Bool {
    return readFromPasteboard(sender.draggingPasteboard())
  }
  
  override func concludeDragOperation(sender: NSDraggingInfo?) {
    highlightFroDragging = false
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
    
    if highlightFroDragging {
      let gradient = NSGradient(startingColor: color,
                                endingColor: NSColor.grayColor())
      gradient?.drawInRect(bounds, relativeCenterPosition: NSZeroPoint)
    }else{
//      if highlighted {
//        NSColor.redColor().set()
//        let rect = CGRect(x: 5, y: bounds.height - 15, width: 10, height: 10)
//        NSBezierPath(ovalInRect:rect).fill()
//      }
      drawDieWithSize(bounds.size)
    }
  }
  
  
  
  func metricsForSize(size:CGSize) -> (edgeLength: CGFloat, dieFrame: CGRect, drawingBounds:CGRect) {
    let edgeLength = min(size.width, size.height)
    let padding = edgeLength / 10.0
    // at center
    let ox = (size.width - edgeLength )/2
    let oy = (size.height - edgeLength)/2
    let drawingBounds = CGRect(x: ox, y: oy, width: edgeLength, height: edgeLength)
    var dieFrame = drawingBounds.insetBy(dx: padding, dy: padding)
    if pressed {
      dieFrame = dieFrame.offsetBy(dx: 0, dy: -edgeLength/40)
    }
    return (edgeLength, dieFrame, drawingBounds)
  }
  
  func diePathWithSize(size:CGSize) -> NSBezierPath {
    let (edgeLength, dieFrame, _) = metricsForSize(size)
    let cornerRadius:CGFloat = edgeLength / 5.0
    return NSBezierPath(roundedRect: dieFrame, xRadius: cornerRadius, yRadius: cornerRadius)
  }
  
  func drawDieWithSize(size:CGSize) {
    if let intValue = intValue {
      let (edgeLength, dieFrame, drawingBounds) = metricsForSize(size)
      let cornerRadius:CGFloat = edgeLength / 5.0
      let dotRadius = edgeLength / 12.0
      let dotFrame = dieFrame.insetBy(dx: dotRadius * 2.5, dy: dotRadius * 2.5)
      
      NSGraphicsContext.saveGraphicsState()
      
      let shadow = NSShadow()
      shadow.shadowOffset = NSSize(width: 0, height: -1)
      shadow.shadowBlurRadius = ( pressed ? edgeLength/100 : edgeLength / 20)
      shadow.set()
      
      color.set()
      NSBezierPath(roundedRect: dieFrame, xRadius: cornerRadius, yRadius: cornerRadius).fill()
      
      NSGraphicsContext.restoreGraphicsState()
      
//      NSColor.redColor().set()
      NSColor.blackColor().set()
      
      let gradient = NSGradient(startingColor: NSColor.redColor(), endingColor: NSColor.greenColor())
//      gradient?.drawInRect(drawingBounds, angle: 180.0)
      
      func drawDot(u: CGFloat, v:CGFloat) {
        let dotOrigin = CGPoint(x: dotFrame.minX + dotFrame.width * u,
                                y: dotFrame.minY + dotFrame.height * v)
        let dotRect = CGRect(origin: dotOrigin, size: CGSizeZero).insetBy(dx: -dotRadius, dy: -dotRadius)
        let path = NSBezierPath(ovalInRect: dotRect)
        path.fill()
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
      }else{
        let paraStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        paraStyle.alignment = .Center
        let font = NSFont.systemFontOfSize(edgeLength * 0.5)
        let attrs = [
          NSForegroundColorAttributeName: NSColor.blackColor(),
          NSFontAttributeName: font,
          NSParagraphStyleAttributeName: paraStyle
        ]
        let string = "\(intValue)" as NSString
        string.drawCenteredInRect(dieFrame, withAttributes: attrs)
      }
    }

  }
  
  @IBAction func saveAsPDF(sender: AnyObject!) {
    let sp = NSSavePanel()
    sp.allowedFileTypes = ["pdf"]
    sp.beginSheetModalForWindow(window!) { [unowned sp] (result) in
      if result == NSModalResponseOK {
        //
        let data = self.dataWithPDFInsideRect(self.bounds)
        do {
          try data.writeToURL(sp.URL!, options: NSDataWritingOptions.DataWritingAtomic)
        }catch {
          let alert = NSAlert()
          alert.messageText = "Save Error"
          alert.informativeText = "Can not save as PDF!"
          alert.runModal()
        }
      }
    }
  }
  
  // pasteboard
  func writeToPasteboard(pasteboard: NSPasteboard) {
    if let value = intValue {
      let text = "\(value)"
      let image = self.bitmapImageRepForCachingDisplayInRect(self.bounds)!
      self.cacheDisplayInRect(self.bounds, toBitmapImageRep: image)
      pasteboard.clearContents()
      pasteboard.setString(text, forType: NSPasteboardTypeString)
      pasteboard.setData(image.representationUsingType(.NSPNGFileType, properties: [:]), forType: NSPasteboardTypePNG)
      self.writePDFInsideRect(self.bounds, toPasteboard: pasteboard)
    }
  }
  
  func readFromPasteboard(pasteboard: NSPasteboard) -> Bool {
    let objects = pasteboard.readObjectsForClasses([NSString.self], options: [:]) as! [String]
    if let str = objects.first {
      intValue = Int(str)
      return true
    }
    return false
  }
  
  @IBAction func cut(sender: AnyObject?) {
    writeToPasteboard(NSPasteboard.generalPasteboard())
    intValue = nil
  }
  
  @IBAction func copy(sender:AnyObject?) {
    writeToPasteboard(NSPasteboard.generalPasteboard())
  }
  
  @IBAction func paste(sender:AnyObject?) {
    readFromPasteboard(NSPasteboard.generalPasteboard())
  }
  
  @IBAction func delete(sener: AnyObject?) {
    intValue = nil
  }
  
  override func validateMenuItem(menuItem: NSMenuItem) -> Bool {
    switch menuItem.action {
    case #selector(copy(_:)):
      return intValue != nil
    case #selector(cut(_:)):
      return intValue != nil
    case #selector(delete(_:)):
      return intValue != nil
    default:
      return super.validateMenuItem(menuItem)
    }
  }
  
  
  
}



