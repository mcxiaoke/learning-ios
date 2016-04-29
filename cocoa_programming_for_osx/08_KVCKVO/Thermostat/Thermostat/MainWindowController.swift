//
//  MainWindowController.swift
//  Thermostat
//
//  Created by mcxiaoke on 16/4/29.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

  dynamic var isOn = true
  //  var temperature = 68
//  dynamic var temperature = 68
  private var temp = 68
  dynamic var temperature: Int {
    set {
      print("set temperature to \(newValue)")
      temp = newValue
    }
    
    get {
      print("get temperature")
      return temp
    }
  }
  
  override var windowNibName: String? {
    return "MainWindowController"
  }

  @IBAction func makeWarmer(sender: AnyObject) {
//    setValue(temperature + 1, forKey: "temperature")
//    willChangeValueForKey("temperature")
    temperature += 1
//    didChangeValueForKey("temperature")
  }
  @IBAction func makeCooler(sender: AnyObject) {
//    setValue(temperature - 1, forKey: "temperature")
//    willChangeValueForKey("temperature")
    temperature -= 1
//    didChangeValueForKey("temperature")
  }
    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
}
