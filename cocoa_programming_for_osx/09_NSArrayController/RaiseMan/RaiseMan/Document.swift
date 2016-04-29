//
//  Document.swift
//  RaiseMan
//
//  Created by mcxiaoke on 16/4/29.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

class Document: NSDocument {
  
  var employees: [Employee] = []

  override init() {
      super.init()
    // Add your subclass-specific initialization here.
  }

  override class func autosavesInPlace() -> Bool {
    return true
  }

  override var windowNibName: String? {
    // Returns the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this property and override -makeWindowControllers instead.
    return "Document"
  }

  override func dataOfType(typeName: String) throws -> NSData {
    return NSData()
  }

  override func readFromData(data: NSData, ofType typeName: String) throws {
    //
  }


}

