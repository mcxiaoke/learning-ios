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

  var window: NSWindow?


  func applicationDidFinishLaunching(aNotification: NSNotification) {
    let flowViewController = ImageViewController()
    flowViewController.title = "Rainy"
    flowViewController.image = NSImage(named: "rainy")
    
    let columnViewController = ImageViewController()
    columnViewController.title = "Cloudy"
    columnViewController.image = NSImage(named: "cloudy")
    
    let tabViewController = NSTabViewController()
    tabViewController.addChildViewController(flowViewController)
    tabViewController.addChildViewController(columnViewController)
    
    let window = NSWindow(contentViewController: tabViewController)
    window.makeKeyAndOrderFront(self)
    self.window = window
  }

  func applicationWillTerminate(aNotification: NSNotification) {
    // Insert code here to tear down your application
  }


}

