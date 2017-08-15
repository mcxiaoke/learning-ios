//
//  AppDelegate.swift
//  WindowProgrammingGuideDemo
//
//  Created by mcxiaoke on 16/6/29.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  var window: NSWindow!
  
  func createNewWindow() -> NSWindow{
    let newWindow = NSWindow(contentRect: NSMakeRect(0, 0, 320, 240), styleMask: NSTitledWindowMask|NSResizableWindowMask|NSMiniaturizableWindowMask|NSClosableWindowMask, backing: NSBackingStoreType.Buffered, defer: false)
    newWindow.title = "New Window"
    newWindow.center()
    newWindow.backgroundColor = NSColor.redColor()
    newWindow.makeKeyAndOrderFront(nil)
    return newWindow
  }

  func applicationDidFinishLaunching(aNotification: NSNotification) {
    self.window = createNewWindow()
  }

  func applicationWillTerminate(aNotification: NSNotification) {
  }


}

