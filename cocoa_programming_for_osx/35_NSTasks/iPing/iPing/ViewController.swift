//
//  ViewController.swift
//  iPing
//
//  Created by mcxiaoke on 16/5/25.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
  
  @IBOutlet var textView: NSTextView!
  @IBOutlet weak var hostField: NSTextField!
  @IBOutlet weak var startButton: NSButton!
  
  var task: NSTask?
  var pipe: NSPipe?
  var fileHandle: NSFileHandle?
  
  @IBAction func togglePing(sender: AnyObject) {
    if let task = task {
      task.interrupt()
    }else {
      let task = NSTask()
      task.launchPath = "/sbin/ping"
      task.arguments = ["-c10", hostField.stringValue]
      
      let pipe = NSPipe()
      task.standardOutput = pipe
//      task.standardError = pipe
      
      let fileHandle = pipe.fileHandleForReading
      
      self.task = task
      self.pipe = pipe
      self.fileHandle = fileHandle
      
      let nc = NSNotificationCenter.defaultCenter()
      nc.removeObserver(self)
      nc.addObserver(self, selector: #selector(receiveDataReadyNotification(_:)), name: NSFileHandleReadCompletionNotification, object: fileHandle)
      nc.addObserver(self, selector: #selector(receiveTaskTerminatedNotification(_:)), name: NSTaskDidTerminateNotification, object: task)
      
      task.launch()
      textView.string = ""
      fileHandle.readInBackgroundAndNotify()
    }
  }
  
  func appendData(data: NSData) {
    if let string = String(data: data, encoding: NSUTF8StringEncoding) {
      let textStorage = textView.textStorage!
      let endRange = NSRange(location: textStorage.length, length: 0)
      textStorage.replaceCharactersInRange(endRange, withString: string)
    }
  }
  
  func receiveDataReadyNotification(notification: NSNotification) {
    if let data = notification.userInfo?[NSFileHandleNotificationDataItem] as? NSData {
      let length = data.length
      print("Received data: \(length) bytes")
      if length > 0{
        self.appendData(data)
      }
    }
    fileHandle?.readInBackgroundAndNotify()
  }
  
  func receiveTaskTerminatedNotification(notification: NSNotification) {
    print("Task terminated.")
    task = nil
    pipe = nil
    fileHandle = nil
    startButton.state = 0
  }

}

