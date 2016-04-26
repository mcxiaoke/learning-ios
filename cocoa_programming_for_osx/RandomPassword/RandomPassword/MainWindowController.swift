//
//  MainWindowController.swift
//  RandomPassword
//
//  Created by mcxiaoke on 16/4/25.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

  @IBOutlet weak var allowSpecialCharsCheckBox: NSButton!
  @IBOutlet weak var textField: NSTextField!
  @IBOutlet weak var lengthSlider: NSSlider!
  
  
  
  @IBAction func lengthChanged(sender: NSSlider) {
    self.lengthLabel.stringValue = "Length: \(sender.intValue)"
  }
  
  @IBOutlet weak var lengthLabel: NSTextField!
  
  @IBAction func generatePassword(sender: AnyObject) {
    let length = self.lengthSlider.intValue
    let special = self.allowSpecialCharsCheckBox.state == NSOnState
    let password = generateRandomString(Int(length),special: special)
    textField.stringValue = password
    
  }
  
  override var windowNibName: String?{
    return "MainWindowController"
  }
  
  override func windowDidLoad() {
      super.windowDidLoad()
      print("window loaded from NIB named \(windowNibName)")
  }
  
  deinit {
    print("\(self) will be deallocated")
  }
    
}
