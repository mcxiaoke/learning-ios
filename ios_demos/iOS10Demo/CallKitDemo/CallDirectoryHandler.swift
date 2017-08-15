//
//  CallDirectoryHandler.swift
//  CallKitDemo
//
//  Created by mcxiaoke on 16/7/16.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Foundation
import CallKit

class CallDirectoryHandler: CXCallDirectoryProvider {

    override func beginRequest(with context: CXCallDirectoryExtensionContext) {
        guard let phoneNumbersToBlock = retrievePhoneNumbersToBlock() else {
            NSLog("Unable to retrieve phone numbers to block")
            let error = NSError(domain: "CallDirectoryHandler", code: 1, userInfo: nil)
            context.cancelRequest(withError: error)
            return
        }
        
        for phoneNumber in phoneNumbersToBlock {
            context.addBlockingEntry(withNextSequentialPhoneNumber: phoneNumber)
        }
        
        guard let (phoneNumbersToIdentify, phoneNumberIdentificationLabels) = retrievePhoneNumbersToIdentifyAndLabels() else {
            NSLog("Unable to retrieve phone numbers to identify and their labels")
            let error = NSError(domain: "CallDirectoryHandler", code: 2, userInfo: nil)
            context.cancelRequest(withError: error)
            return
        }
        
        for (phoneNumber, label) in zip(phoneNumbersToIdentify, phoneNumberIdentificationLabels) {
            context.addIdentificationEntry(withNextSequentialPhoneNumber: phoneNumber, label: label)
        }
        
        context.completeRequest()
    }
    
    private func retrievePhoneNumbersToBlock() -> [String]? {
        NSLog("retrieve list of phone numbers to block")
        return []
    }
    
    private func retrievePhoneNumbersToIdentifyAndLabels() -> (phoneNumbers: [String], labels: [String])? {
      let start = NSDate().timeIntervalSince1970
      var numbers = [String]()
      var labels = [String]()
      // count need <= 2w
      for i in 18651600000..<18651620000 {
        numbers.append("+86\(i)")
        labels.append("Hello - \(i % 100)")
      }
      numbers.append("+8618651629700")
      labels.append("骚扰电话")
      let elapsed = NSDate().timeIntervalSince1970 - start
      NSLog("retrievePhoneNumbersToIdentifyAndLabels elapsed = \(elapsed)")
      NSLog("retrieve list of phone numbers to identify, and their labels")
      return (numbers, labels)
    }
    
}
