//
//  AppDelegate.swift
//  Thermostat
//
//  Created by mcxiaoke on 16/4/29.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  var mainWindowController:MainWindowController?

  func applicationDidFinishLaunching(aNotification: NSNotification) {
    let mwc = MainWindowController()
    mwc.showWindow(self)
    self.mainWindowController = mwc
  }

}

