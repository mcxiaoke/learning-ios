//
//  MainWindowController.swift
//  ImageGrid
//
//  Created by mcxiaoke on 16/5/5.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
  
  override var windowNibName: String? {
    return "MainWindowController"
  }

    override func windowDidLoad() {
        super.windowDidLoad()
      let superview = window?.contentView
      let frame = NSRect(x: 40, y: 40, width: 200, height: 40)
      let button = NSButton(frame:frame)
      button.title = "Click Me!"
      button.alignment = .Center
      superview?.addSubview(button)
    }
    
}
