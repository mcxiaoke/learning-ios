//
//  WordCountViewController.swift
//  BabyScript
//
//  Created by mcxiaoke on 16/6/28.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

class WordCountViewController: NSViewController {

  @IBOutlet weak var wordCount: NSTextField!
  @IBOutlet weak var paragraphCount: NSTextField!
  
  @IBAction func dismissWordCountWindow(sender: AnyObject){
    NSApplication.sharedApplication().stopModal()
  }
  
  
    
}
