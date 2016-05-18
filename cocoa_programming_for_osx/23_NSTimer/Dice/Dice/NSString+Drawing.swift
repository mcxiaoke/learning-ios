//
//  NSString+Drawing.swift
//  Dice
//
//  Created by mcxiaoke on 16/5/16.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

extension NSString {

  func drawCenteredInRect(rect:NSRect, withAttributes attributes: [String: AnyObject]?) {
    let stringSize = sizeWithAttributes(attributes)
    let point = NSPoint(x: rect.origin.x + (rect.width - stringSize.width)/2.0,
                        y: rect.origin.y + (rect.height - stringSize.height)/2.0)
    drawAtPoint(point, withAttributes: attributes)
  }
  
}
