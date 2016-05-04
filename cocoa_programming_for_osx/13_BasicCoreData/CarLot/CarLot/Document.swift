//
//  Document.swift
//  CarLot
//
//  Created by mcxiaoke on 16/5/4.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

class Document: NSPersistentDocument {
  
  @IBOutlet weak var tableView:NSTableView!
  @IBOutlet weak var arrayController:NSArrayController!
  
  
  @IBAction func addCar(car:AnyObject) {
    let windowController = windowControllers[0]
    let window = windowController.window!
    let endedEditing = window.makeFirstResponder(window)
    if !endedEditing {
      print("Unable to end editing.")
      return
    }
    let car = arrayController.newObject() as! NSObject
    arrayController.addObject(car)
    arrayController.rearrangeObjects()
    let sortedCars = arrayController.arrangedObjects as! [NSObject]
    let row = sortedCars.indexOf(car)!
    print("starting edit car in row \(row)")
    tableView.editColumn(0, row: row, withEvent: nil, select: true)
  }

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

}
