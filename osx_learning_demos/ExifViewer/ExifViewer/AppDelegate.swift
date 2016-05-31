//
//  AppDelegate.swift
//  ExifViewer
//
//  Created by mcxiaoke on 16/5/25.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



  func applicationDidFinishLaunching(aNotification: NSNotification) {
    print("applicationDidFinishLaunching")
    NSValueTransformer.setValueTransformer(ValueTextColorTransformer(), forName: "ValueTextColorTransformer")
  }

  func applicationWillTerminate(aNotification: NSNotification) {
    print("applicationWillTerminate")
  }
  

}

