//
//  ChatWindowController.swift
//  Chatter
//
//  Created by mcxiaoke on 16/5/5.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

private let ChatWindowControllerDidSendMessageNotification
  = "com.mcxiaoke.osx.chatter.ChatWindowControllerDidSendMessageNotification"
private let ChatWindowControllerMessageKey
  = "com.mcxiaoke.osx.chatter.ChatWindowControllerMessageKey"
private let ChatWindowControllerNameKey
  = "com.mcxiaoke.osx.chatter.ChatWindowControllerNameKey"

class ChatWindowController: NSWindowController {
  
  var windowIndex = 0
  
  dynamic var log: NSAttributedString = NSAttributedString(string: "")
  dynamic var name: String?
  dynamic var message: String?
  
  @IBOutlet var textView: NSTextView!
  
  @IBAction func send(sender: AnyObject) {
    sender.window?.endEditingFor(nil)
    let name = self.name ?? sender.window.title
    if let message = message {
      let userInfo = [ChatWindowControllerMessageKey: message, ChatWindowControllerNameKey: name]
      let nc = NSNotificationCenter.defaultCenter()
      nc.postNotificationName(ChatWindowControllerDidSendMessageNotification, object: self, userInfo: userInfo)
    }
    message = ""
  }
  
  func receiveDidSendMessageNotification(note: NSNotification) {
    let fromMe = ((note.object as? ChatWindowController) == self)
    let mutableLog = log.mutableCopy() as! NSMutableAttributedString
    if log.length > 0 {
      mutableLog.appendAttributedString(NSAttributedString(string: "\n"))
    }
    
    let userInfo = note.userInfo! as! [String: String]
    let name = userInfo[ChatWindowControllerNameKey]!
    let message = userInfo[ChatWindowControllerMessageKey]!
    let formatter = NSDateFormatter()
    formatter.dateStyle = .NoStyle
    formatter.timeStyle = .MediumStyle
    let time = formatter.stringFromDate(NSDate())
    let line = NSMutableAttributedString(string: "\(name): (\(time)) \(message)")
    let color = fromMe ? NSColor.blueColor() : NSColor.redColor()
    let range = NSRange(location: 0, length: line.length)
    line.addAttributes([NSForegroundColorAttributeName: color], range: range)
    mutableLog.appendAttributedString(line)
    log = mutableLog.copy() as! NSAttributedString
    textView.scrollRangeToVisible(NSRange(location: log.length, length: 0))
  }
  
  override var windowNibName: String? {
    return "ChatWindowController"
  }

    override func windowDidLoad() {
      super.windowDidLoad()
      self.window?.title = "Window \(windowIndex)"
      self.name = "User \(windowIndex)"
      let nc = NSNotificationCenter.defaultCenter()
      nc.addObserver(self, selector: #selector(receiveDidSendMessageNotification), name: ChatWindowControllerDidSendMessageNotification, object: nil)
    }
  
  deinit {
    let nc = NSNotificationCenter.defaultCenter()
    nc.removeObserver(self)
  }
    
}
