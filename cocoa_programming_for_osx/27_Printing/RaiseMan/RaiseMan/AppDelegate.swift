//
//  AppDelegate.swift
//  RaiseMan
//
//  Created by mcxiaoke on 16/4/29.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



  func applicationDidFinishLaunching(aNotification: NSNotification) {
    // Insert code here to initialize your application
    showAppDirectory()
  }

  func applicationWillTerminate(aNotification: NSNotification) {
    // Insert code here to tear down your application
  }
  
  func showAppDirectory(){
    let fm = NSFileManager()
    let urls = fm.URLsForDirectory(.ApplicationSupportDirectory, inDomains: .UserDomainMask)
    if let url = urls.first {
      let id = NSBundle.mainBundle().bundleIdentifier!
      let appSupport = url.URLByAppendingPathComponent(id)
      print(appSupport)
    }
  }


}

