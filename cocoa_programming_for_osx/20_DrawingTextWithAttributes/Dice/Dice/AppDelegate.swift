//
//  AppDelegate.swift
//  Dice
//
//  Created by mcxiaoke on 16/5/5.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  func applicationWillTerminate(aNotification: NSNotification) {
    // Insert code here to tear down your application
  }
  var mainWindowController:MainWindowController?

  func applicationDidFinishLaunching(aNotification: NSNotification) {
    let mwc = MainWindowController()
    mwc.showWindow(self)
    self.mainWindowController = mwc
  }

}

