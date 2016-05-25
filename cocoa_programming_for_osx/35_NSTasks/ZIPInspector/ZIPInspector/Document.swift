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
  
  /**
 
   https://developer.apple.com/library/ios/documentation/Miscellaneous/Reference/UTIRef/Articles/System-DeclaredUniformTypeIdentifiers.html
   
 **/
  private func findLauchCommand(fileURL: NSURL) -> (String, [String]) {
    let fileName = fileURL.path!
    let ext = fileURL.pathExtension ?? ""
    Swift.print("file extension: \(ext)")
    if fileName.hasSuffix(".tar.gz") {
      return ("/usr/bin/tar",["-tf", fileName])
    }
    switch ext {
    case "jar", "zip", "apk":
      return ("/usr/bin/zipinfo",["-1", fileName])
    case "tar", "tgz", "xz", "bz2":
      return ("/usr/bin/tar",["-tf", fileName])
    default:
      return ("/usr/bin/file",[fileName])
    }
  }

  override var windowNibName: String? {
    return "Document"
  }

  override func readFromURL(url: NSURL, ofType typeName: String) throws {
    Swift.print("url = \(url)")
    let (launchPath, arguments) = findLauchCommand(url)
    let task = NSTask()
    task.launchPath = launchPath
    task.arguments = arguments
    
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
      Swift.print("fileNames = \(fileNames)")
      tableView?.reloadData()
    }
    
  }


}

