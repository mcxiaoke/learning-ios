//
//  CarArrayController.swift
//  CarLot
//
//  Created by mcxiaoke on 16/5/4.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

class CarArrayController: NSArrayController {
  
  override func newObject() -> AnyObject {
    let newObj = super.newObject() as! NSObject
    newObj.setValue("New Car", forKey: "makeModel")
    newObj.setValue(NSDate(), forKey: "datePurchased")
    newObj.setValue(10000.0, forKey: "price")
    newObj.setValue(false, forKey: "onSpecial")
    print("new Object: \(newObj)")
    return newObj
  }

}
