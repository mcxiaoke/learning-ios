//
//  Person.swift
//  Thermostat
//
//  Created by mcxiaoke on 16/4/29.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

class Person {
  dynamic var firstName = ""
  dynamic var lastName = ""
  
  dynamic var fullName: String {
    return "\(firstName) \(lastName)"
  }
  
  class func keyPathsForValuesAffectingFullName() -> NSSet {
    return Set(["firstName", "lastName"])
  }

}
