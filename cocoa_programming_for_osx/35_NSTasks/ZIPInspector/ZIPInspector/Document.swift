//
//  Document.swift
//  ZIPInspector
//
//  Created by mcxiaoke on 16/5/25.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa
import CoreFoundation

class Document: NSDocument, NSTableViewDelegate, NSTableViewDataSource {

  @IBOutlet weak var tableView: NSTableView!
  
  var fileNames: [String] = []
  
  // table view
  func numberOfRowsInTableView(tableView: NSTableView) -> Int {
    return fileNames.count
  }
  
  func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
    return fileNames[row]
  }
  
  override init() {
    super.init()
  }

  override var windowNibName: String? {
    return "Document"
  }

  override func readFromURL(url: NSURL, ofType typeName: String) throws {
    Swift.print("url = \(url.path)")
    let fileName = url.path!
    let task = NSTask()
    task.launchPath = "/usr/bin/zipinfo"
    task.arguments = ["-1", fileName]
    
    let outPipe = NSPipe()
    task.standardOutput = outPipe
    task.launch()
    
    let fileHandle = outPipe.fileHandleForReading
    let data = fileHandle.readDataToEndOfFile()
    
    task.waitUntilExit()
    let status = task.terminationStatus
    
    if status != 0 {
      let errorDomain = "com.mcxiaoke.ProcessReturnCodeErrorDomain"
      let errorInfo
        = [ NSLocalizedFailureReasonErrorKey : "zipinfo returned \(status)"]
      throw NSError(domain: errorDomain, code: 0, userInfo: errorInfo)
    }
    
    if let string = String(data: data, encoding: NSUTF8StringEncoding) {
      fileNames = string.componentsSeparatedByString("\n") as [String]
      Swift.print("fileNames = \(fileName)")
      tableView?.reloadData()
    }
    
  }


}

