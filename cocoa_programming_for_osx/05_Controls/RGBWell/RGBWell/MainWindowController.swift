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
  let max = 255.0
  
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
    let ri = Int(r * max)
    let gi = Int(g * max)
    let bi = Int(b * max)
    colorLabel.stringValue = String(format: "#%02X%02X%02X",ri,gi,bi)
    
  }
  
  override var windowNibName: String? {
    return "MainWindowController"
  }
  
  @IBAction func adjustRed(sender:NSSlider) {
    print("R slider's value is \(sender.floatValue)")
    r = sender.doubleValue
    updateColor()
  }
  
  @IBAction func adjustGreen(sender:NSSlider) {
    print("G slider's value is \(sender.floatValue)")
    g = sender.doubleValue
    updateColor()
  }
  
  @IBAction func adjustBlue(sender:NSSlider) {
    print("B slider's value is \(sender.floatValue)")
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
  }


}
