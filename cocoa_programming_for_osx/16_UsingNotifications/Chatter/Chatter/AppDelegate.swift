//
//  AppDelegate.swift
//  Chatter
//
//  Created by mcxiaoke on 16/5/5.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
  
  var windowIndex = 0

  var windowControllers: [ChatWindowController] = []
  
  func addWindowController() {
    windowIndex += 1
    let windowController = ChatWindowController()
    windowController.windowIndex = windowIndex
    windowController.showWindow(self)
    windowControllers.append(windowController)
  }
  
  @IBAction func displayNewWindow(sender:NSButton) {
    addWindowController()
  }
  
  func applicationDidFinishLaunching(aNotification: NSNotification) {
    addWindowController()
  }

  func applicationWillTerminate(aNotification: NSNotification) {
    // Insert code here to tear down your application
  }
  
  func applicationDidResignActive(notification: NSNotification) {
    NSBeep()
  }


}

