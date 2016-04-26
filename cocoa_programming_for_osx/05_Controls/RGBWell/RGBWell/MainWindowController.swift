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
  
  func updateColor() {
    let newColor = NSColor(calibratedRed: CGFloat(r),
                           green: CGFloat(g),
                           blue: CGFloat(b),
                           alpha: CGFloat(a))
    colorWell.color = newColor
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
    rSlider.doubleValue = r
    gSlider.doubleValue = g
    bSlider.doubleValue = b
    updateColor()
  }


}
