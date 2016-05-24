//
//  MainWindowController.swift
//  ViewControl
//
//  Created by mcxiaoke on 16/5/24.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
  
  override var windowNibName: String? {
    return "MainWindowController"
  }

    override func windowDidLoad() {
        super.windowDidLoad()
      print("windowDidLoad")
      setUpViewController()
    }
  
  func setUpViewController(){
    let flowViewController = ImageViewController()
    flowViewController.title = "Rainy"
    flowViewController.image = NSImage(named: "rainy")
    
    let columnViewController = ImageViewController()
    columnViewController.title = "Cloudy"
    columnViewController.image = NSImage(named: "cloudy")
    
    let tabViewController = NerdTabViewController()
    tabViewController.addChildViewController(flowViewController)
    tabViewController.addChildViewController(columnViewController)
    self.contentViewController = tabViewController
  }
  
}
