//
//  AppDelegate.swift
//  AutoLabelOut
//
//  Created by mcxiaoke on 16/5/19.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  @IBOutlet weak var window: NSWindow!


  func applicationDidFinishLaunching(aNotification: NSNotification) {
    let label = NSTextField(frame: NSRect.zero)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.stringValue = "Label"
    label.backgroundColor = NSColor.clearColor()
    label.editable = false
    label.selectable = false
    label.bezeled = false
    
    let textField = NSTextField(frame: NSRect.zero)
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.action = #selector(NSControl.takeStringValueFrom(_:))
    textField.target = label
    
    let superview = window.contentView! as NSView
    superview.addSubview(label)
    superview.addSubview(textField)
    
    let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
      "|-[label]-[textField(>=100)]-|", options: .AlignAllBaseline, metrics: nil, views: ["label": label, "textField": textField])
    NSLayoutConstraint.activateConstraints(horizontalConstraints)
    
    let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
      "V:|-[textField]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["textField": textField])
    NSLayoutConstraint.activateConstraints(verticalConstraints)
    
    superview.updateConstraintsForSubtreeIfNeeded()
    if superview.hasAmbiguousLayout {
      superview.exerciseAmbiguityInLayout()
    }
//    window.visualizeConstraints(superview.constraints)
    
  }

  func applicationWillTerminate(aNotification: NSNotification) {
    // Insert code here to tear down your application
  }


}

