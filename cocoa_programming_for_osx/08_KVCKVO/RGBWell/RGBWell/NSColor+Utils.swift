//
//  NSColor+Utils.swift
//  RGBWell
//
//  Created by mcxiaoke on 16/4/29.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

let max = 255.0
public extension NSColor {
  var hexString: String {
    let red = Int(round(self.redComponent * 0xFF))
    let green = Int(round(self.greenComponent * 0xFF))
    let blue = Int(round(self.blueComponent * 0xFF))
    return String(format: "#%02X%02X%02X",red,green,blue)
  }
}
