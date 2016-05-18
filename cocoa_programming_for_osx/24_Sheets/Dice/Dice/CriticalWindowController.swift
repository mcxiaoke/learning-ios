//
//  CriticalWindowController.swift
//  Dice
//
//  Created by mcxiaoke on 16/5/18.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

class CriticalWindowController: NSWindowController {
  
  override var windowNibName: String? {
    return "CriticalWindowController"
  }

  enum ModalResult: Int {
    case Accept
    case Cancel
  }
  
  func runModal() -> ModalResult {
    let app = NSApplication.sharedApplication()
    let returnCode = app.runModalForWindow(window!)
    if let result = ModalResult(rawValue: returnCode) {
      return result
    }else {
      fatalError("Failed to map \(returnCode) to ModalResult")
    }
  }
  
  @IBAction func dismiss(sender: NSButton) {
    let app = NSApplication.sharedApplication()
    app.stopModalWithCode(ModalResult.Accept.rawValue)
  }
    
}
