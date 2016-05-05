//
//  IsNotEmptyTransformer.swift
//  Chatter
//
//  Created by mcxiaoke on 16/5/5.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

// need @objc 
// from http://stackoverflow.com/questions/25534334/custom-nsvaluetransformer-in-xcode-6-with-swift
@objc(IsNotEmptyTransformer) class IsNotEmptyTransformer: NSValueTransformer {
  
  override class func transformedValueClass() -> AnyClass {
    return NSNumber.self
  }
  
  override class func allowsReverseTransformation() -> Bool {
    return false
  }
  
  override func transformedValue(value: AnyObject?) -> AnyObject? {
    if let str = value as? String {
      return NSNumber(bool: !str.isEmpty)
    }else {
      return NSNumber(bool: false)
    }
  }


}
