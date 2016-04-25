//
//  MainWindowController.swift
//  RandomPassword
//
//  Created by mcxiaoke on 16/4/25.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

  @IBOutlet weak var textField: NSTextField!
  
  
  
  @IBAction func generatePassword(sender: AnyObject) {
    let password = generateRandomString(8)
    textField.stringValue = password
    
  }
  
  override var windowNibName: String?{
    return "MainWindowController"
  }
  
    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
}
