//
//  MainWindowController.swift
//  RGBWell
//
//  Created by mcxiaoke on 16/4/26.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
  
  @IBOutlet weak var colorLabel: NSTextField!
  
  private let a = 1.0
  
  dynamic  var r = 0.0
  dynamic  var g = 0.0
  dynamic  var b = 0.0
  
  dynamic var color:NSColor {
    return NSColor(calibratedRed: CGFloat(r),
                   green: CGFloat(g),
                   blue: CGFloat(b),
                   alpha: CGFloat(a))
  }
  
  dynamic var colorHex: String {
    return color.hexString
  }
  
  class func keyPathsForValuesAffectingColor() -> NSSet {
    return Set(["r", "g", "b"])
  }
  
  class func keyPathsForValuesAffectingColorHex() -> NSSet {
    return Set(["r", "g", "b"])
  }
  
  @IBAction func colorChanged(sender:AnyObject) {
    updateColor()
  }
  
  func updateColor() {
    colorLabel.textColor = color
  }
  
  override var windowNibName: String? {
    return "MainWindowController"
  }
  
  override func windowDidLoad() {
    super.windowDidLoad()
    updateColor()
    setupGesture()
  }
  
  func setupGesture() {
    let action = #selector(copyColor(_:))
    let gesture = NSClickGestureRecognizer(target: self, action:action)
    gesture.numberOfClicksRequired = 2
    self.colorLabel.addGestureRecognizer(gesture)
  }
  
  func copyColor(gesture:NSClickGestureRecognizer!) {
    let pasteBoard = NSPasteboard.generalPasteboard()
    pasteBoard.clearContents()
    pasteBoard.setString(colorHex, forType: NSStringPboardType)
    let alert = NSAlert()
    alert.alertStyle = NSAlertStyle.InformationalAlertStyle
    alert.messageText = "Copy Color"
    alert.informativeText = "Color:\(colorHex) is copied to pasteboard."
    alert.addButtonWithTitle("OK")
//    alert.runModal()
    alert.beginSheetModalForWindow(self.window!, completionHandler: nil)
  }


}
