//
//  WindowController.swift
//  BabyScript
//
//  Created by mcxiaoke on 16/6/28.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.shouldCascadeWindows = true
  }

    override func windowDidLoad() {
        super.windowDidLoad()
      if let window = window, screen = window.screen {
        let offsetFromLeftOfScreen: CGFloat = 20
        let offsetFromTopOfScreen: CGFloat = 20
        let screenRect = screen.visibleFrame
        let newOriginY = CGRectGetMaxY(screenRect) - window.frame.height - offsetFromTopOfScreen
        window.setFrameOrigin(NSPoint(x: offsetFromLeftOfScreen, y: newOriginY))
      }
    }

}
