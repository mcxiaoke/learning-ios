//
//  Employee.swift
//  RaiseMan
//
//  Created by mcxiaoke on 16/4/29.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Foundation

class Employee: NSObject {
  var name: String? = "New Employee"
  var raise: Float = 0.05
  
  override var description: String {
    return "Employee(\(name!), \(raise))"
  }
  
  func validateRaise(raiseNumbeerPointer: AutoreleasingUnsafeMutablePointer<NSNumber?>,
                     error outError: NSErrorPointer) -> Bool {
    let raiseNumber = raiseNumbeerPointer.memory
    if raiseNumber == nil {
      let domain = "UserInputValidationErrorDomain"
      let code = 0
      let userInfo = [NSLocalizedDescriptionKey: "An employee's raise must be a number"]
      outError.memory = NSError(domain: domain, code: code, userInfo: userInfo)
      return false
//      raiseNumbeerPointer.memory = 0.0
//      return true
    }else{
      return true
    }
  }
}