//
//  ValueTextColorTransformer.swift
//  ExifViewer
//
//  Created by mcxiaoke on 16/5/30.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

// http://bluelemonbits.com/index.php/2016/02/07/using-nsvaluetransformers-value-transformer-swift-2-0/
class ValueTextColorTransformer: NSValueTransformer {
  override class func transformedValueClass() -> AnyClass { //What do I transform
    return NSColor.self
  }
  
  override class func allowsReverseTransformation() -> Bool { //Can I transform back?
    return false
  }
  
  override func transformedValue(value: AnyObject?) -> AnyObject? { //Perform transformation
    if let modified = value as? Bool {
      if modified { return NSColor.redColor() }
    }
    return NSColor.blackColor()
  }

}
