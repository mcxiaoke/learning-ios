//
//  AppDelegate.swift
//  SpeakLine
//
//  Created by mcxiaoke on 16/4/27.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  var window: NSWindow?

  func applicationDidFinishLaunching(aNotification: NSNotification) {
    let vc1 = MainViewController()
    vc1.title = "SpeakLine 1"
    
    let vc2 = MainViewController()
    vc2.title = "SpeakLine 2"
    
    let tabViewController = NSTabViewController()
    tabViewController.addChildViewController(vc1)
    tabViewController.addChildViewController(vc2)
    
    let window = NSWindow(contentViewController: tabViewController)
    window.makeKeyAndOrderFront(self)
    self.window = window
  }

  func applicationWillTerminate(aNotification: NSNotification) {
    // Insert code here to tear down your application
  }


}

