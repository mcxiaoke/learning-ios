//
//  AppDelegate.swift
//  ViewControl
//
//  Created by mcxiaoke on 16/5/23.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
  
  var mainWindowController:MainWindowController?

  func applicationDidFinishLaunching(aNotification: NSNotification) {
    let window = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 320, height: 240),
                          styleMask: NSTitledWindowMask|NSResizableWindowMask|NSClosableWindowMask|NSBorderlessWindowMask,
                          backing: NSBackingStoreType.Buffered,
                          defer: false)
    let mwc = MainWindowController(window: window)
    mwc.showWindow(self)
    mwc.setUpViewController()
    self.mainWindowController = mwc
  }
  
  func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
    return true
  }
  
//  var window: NSWindow?
//
//  func applicationDidFinishLaunching(aNotification: NSNotification) {
//    let flowViewController = ImageViewController()
//    flowViewController.title = "Rainy"
//    flowViewController.image = NSImage(named: "rainy")
//    
//    let columnViewController = ImageViewController()
//    columnViewController.title = "Cloudy"
//    columnViewController.image = NSImage(named: "cloudy")
//    
//    let tabViewController = NSTabViewController()
//    tabViewController.addChildViewController(flowViewController)
//    tabViewController.addChildViewController(columnViewController)
//    
//    let window = NSWindow(contentViewController: tabViewController)
//    window.makeKeyAndOrderFront(self)
//    self.window = window
//  }

}

