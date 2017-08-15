//
//  ViewController.swift
//  BabyScript
//
//  Created by mcxiaoke on 16/6/28.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
  
  @IBOutlet var text:NSTextView!
  
  @IBAction func showWordCountWindow(sender:AnyObject){
    let storyboard = NSStoryboard(name: "Main", bundle: nil)
    let wordCountWindowController = storyboard.instantiateControllerWithIdentifier("WordCountWindowController") as! NSWindowController
    if  let wordCountWindow = wordCountWindowController.window, textStorage = text.textStorage {
      let wordCountViewController = wordCountWindow.contentViewController as! WordCountViewController
      wordCountViewController.wordCount.stringValue = "\(textStorage.words.count)"
      wordCountViewController.paragraphCount.stringValue = "\(textStorage.paragraphs.count)"
      NSApplication.sharedApplication().runModalForWindow(wordCountWindow)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    text.toggleRuler(nil)
  }

}

