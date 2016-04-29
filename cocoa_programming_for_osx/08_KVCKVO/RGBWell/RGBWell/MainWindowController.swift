//
//  MainWindowController.swift
//  RGBWell
//
//  Created by mcxiaoke on 16/4/26.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
  var r = 0.0
  var g = 0.0
  var b = 0.0
  let a = 1.0
  
  @IBOutlet weak var colorWell:NSColorWell!
  @IBOutlet weak var rSlider:NSSlider!
  @IBOutlet weak var gSlider:NSSlider!
  @IBOutlet weak var bSlider:NSSlider!
  @IBOutlet weak var colorLabel: NSTextField!
  
  func updateColor() {
    let newColor = NSColor(calibratedRed: CGFloat(r),
                           green: CGFloat(g),
                           blue: CGFloat(b),
                           alpha: CGFloat(a))
    if newColor.brightnessComponent > 0.9 {
      colorLabel.backgroundColor = NSColor.blackColor()
    }else {
      colorLabel.backgroundColor = NSColor.whiteColor()
    }
    colorWell.color = newColor
    colorLabel.textColor = newColor
    colorLabel.stringValue = formatColor(r, g: g, b: b)
    
  }
  
  func formatColor(r:Double, g:Double, b:Double) -> String {
    let max = 255.0
    let ri = Int(r * max)
    let gi = Int(g * max)
    let bi = Int(b * max)
    return String(format: "#%02X%02X%02X",ri,gi,bi)
  }
  
  override var windowNibName: String? {
    return "MainWindowController"
  }
  
  @IBAction func adjustRed(sender:NSSlider) {
    r = sender.doubleValue
    updateColor()
  }
  
  @IBAction func adjustGreen(sender:NSSlider) {
    g = sender.doubleValue
    updateColor()
  }
  
  @IBAction func adjustBlue(sender:NSSlider) {
    b = sender.doubleValue
    updateColor()
  }
  
  override func windowDidLoad() {
    super.windowDidLoad()
    colorLabel.alignment = NSTextAlignment.Center
    rSlider.doubleValue = r
    gSlider.doubleValue = g
    bSlider.doubleValue = b
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
    let color = formatColor(r, g: g, b: b)
    let pasteBoard = NSPasteboard.generalPasteboard()
    pasteBoard.clearContents()
    pasteBoard.setString(color, forType: NSStringPboardType)
    let alert = NSAlert()
    alert.alertStyle = NSAlertStyle.InformationalAlertStyle
    alert.messageText = "Copy Color"
    alert.informativeText = "Color:\(color) is copied to pasteboard."
    alert.addButtonWithTitle("OK")
//    alert.runModal()
    alert.beginSheetModalForWindow(self.window!, completionHandler: nil)
  }


}
