//
//  ImagePropertyItem.swift
//  ExifViewer
//
//  Created by mcxiaoke on 16/5/27.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Foundation


let imageIOBundle = NSBundle(identifier:"com.apple.ImageIO.framework")

class ImagePropertyItem : NSObject {
  var key:String
  var value:String
  let cat:String?
  let rawKey:String
  let rawValue:AnyObject
  let rawCat:String?
  
  init(rawKey:String, rawValue:AnyObject, rawCat:String?){
    self.rawKey = rawKey
    self.rawValue = rawValue
    self.rawCat = rawCat
    self.key = ImagePropertyItem.normalizeKey(rawKey, rawCat: rawCat)
    self.value = ImagePropertyItem.normalizeValue(rawValue)
    if let rawCat = rawCat {
      self.cat = ImagePropertyItem.getImageIOLocalizedString(rawCat)
    }else{
      self.cat = nil
    }
    super.init()
  }
  
  override var description: String {
    return "(\(rawKey) = \(rawValue) \(rawCat ?? ""))"
  }
  
  class func normalizeKey(rawKey: String, rawCat:String?) -> String {
    let key = getImageIOLocalizedString(rawKey)
    if let prefix = getCategoryPrefix(rawCat) {
      return "\(prefix) \(key)"
    }else {
      return key
    }
  }
  
  class func normalizeValue(value:AnyObject) -> String {
    let valueStr:String
    if let value = value as? NSArray {
      valueStr = value.componentsJoinedByString(", ")
    }else {
      valueStr = "\(value)"
    }
    return valueStr
  }
  
  class func getImageIOLocalizedString(key: String) -> String
  {
    return imageIOBundle?.localizedStringForKey(key, value: key, table: "CGImageSource") ?? key
  }
  
  class func getCategoryPrefix(category: String?) -> String? {
    if let category = category {
      if let prefix = ImageCategoryPrefixKeys[category]{
        return "\(prefix) "
      }
    }
    return nil
  }
  
  class func parse(properties: Dictionary<String,AnyObject>, category:String? = nil) -> [ImagePropertyItem]{
    var items:[ImagePropertyItem] = []
    properties.forEach { (key, value) in
      if let child  = value as? Dictionary<String,AnyObject> {
        items += parse(child, category: key)
      }else {
        let newItem = ImagePropertyItem(rawKey: key, rawValue: value, rawCat: category)
        items.append(newItem)
      }
    }
    return items
  }
}