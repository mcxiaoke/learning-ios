//
//  ConfigurationWindowController.swift
//  Dice
//
//  Created by mcxiaoke on 16/5/18.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

struct DieConfiguration {
  let color: NSColor
  let rolls: Int
  
  init(color: NSColor, rolls: Int){
    self.color = color
    self.rolls = max(rolls, 1)
  }
}

class ConfigurationWindowController: NSWindowController {
  
  private dynamic var color: NSColor = NSColor.whiteColor()
  private dynamic var rolls: Int = 10
  
  var configuration: DieConfiguration {
    set{
      color = newValue.color
      rolls = newValue.rolls
    }
    
    get {
      return DieConfiguration(color: color, rolls: rolls)
    }
  }
  
  override var windowNibName: String? {
    return "ConfigurationWindowController"
  }
  
  func presentAsSheetOnWindow(window:NSWindow, completionHandler: (DieConfiguration?) -> Void) {
    window.beginSheet(self.window!) { (response) in
      if  response == NSModalResponseOK {
        completionHandler(self.configuration)
      }else {
        completionHandler(nil)
      }
    }
  }
  
  func dismissWithModalResponse(response: NSModalResponse) {
    window?.sheetParent?.endSheet(window!, returnCode: response)
  }
  
  @IBAction func okayButtonClicked(sender: NSButton) {
    window?.endEditingFor(nil)
    dismissWithModalResponse(NSModalResponseOK)
  }
  
  @IBAction func cancelButtonClicked(sender: NSButton) {
    dismissWithModalResponse(NSModalResponseCancel)
  }
    
}
