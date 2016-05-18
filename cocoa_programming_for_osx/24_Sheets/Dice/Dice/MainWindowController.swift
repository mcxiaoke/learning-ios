//
//  MainWindowController.swift
//  Dice
//
//  Created by mcxiaoke on 16/5/5.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
  
  var configurationWindowController: ConfigurationWindowController?
  
  @IBAction func showDieConfiguration(sender: AnyObject?) {
    if let window = window, let dieView = window.firstResponder as? DieView {
      let windowController = ConfigurationWindowController()
      windowController.presentAsSheetOnWindow(window, completionHandler: { (configuration) in
        if let configuration = configuration {
          dieView.color = configuration.color
          dieView.numberOfTimesToRoll = configuration.rolls
        }
      })
//      windowController.configuration = DieConfiguration(color: dieView.color, rolls: dieView.numberOfTimesToRoll)
//      window.beginSheet(windowController.window!, completionHandler: { (response) in
//        if  response == NSModalResponseOK {
//          let configuration = self.configurationWindowController!.configuration
//          dieView.color = configuration.color
//          dieView.numberOfTimesToRoll = configuration.rolls
//        }
//        self.configurationWindowController = nil
//      })
//      self.configurationWindowController = windowController
    }
  }
  
  override func validateMenuItem(menuItem: NSMenuItem) -> Bool {
    switch menuItem.action {
    case #selector(showDieConfiguration(_:)):
      return window?.firstResponder is DieView
    default:
      return super.validateMenuItem(menuItem)
    }
    
  }
  
  override var windowNibName: String? {
    return "MainWindowController"
  }
  
  func showModalWindow() {
    let windowController = CriticalWindowController()
    switch windowController.runModal() {
    case .Accept:
      break
    case .Cancel:
      break
    }
  }
    
}
