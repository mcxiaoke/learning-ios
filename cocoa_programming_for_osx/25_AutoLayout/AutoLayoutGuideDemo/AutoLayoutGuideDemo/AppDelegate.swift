//
//  AppDelegate.swift
//  AutoLayoutGuideDemo
//
//  Created by mcxiaoke on 16/5/20.
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

