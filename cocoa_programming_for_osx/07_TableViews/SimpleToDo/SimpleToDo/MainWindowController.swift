//
//  MainWindowController.swift
//  SimpleToDo
//
//  Created by mcxiaoke on 16/4/27.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController,
        NSTableViewDelegate,
        NSTableViewDataSource,
        NSTextFieldDelegate{
  
  var items:[String] = []
  
  @IBOutlet weak var textField: NSTextField!
  @IBOutlet weak var tableView: NSTableView!
  @IBOutlet weak var addButton: NSButton!
  
  @IBAction func addItem(sender: AnyObject) {
    self.items.append(self.textField.stringValue)
    self.textField.stringValue = ""
    updateUI()
    self.tableView.reloadData()
  }
  
  override func controlTextDidChange(obj: NSNotification) {
    updateUI()
  }
  
  func updateUI() {
    self.addButton.enabled = !self.textField.stringValue.isEmpty
  }
  
  // table view
  func numberOfRowsInTableView(tableView: NSTableView) -> Int {
    return items.count
  }
  
  func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
    return items[row]
  }
  
  override var windowNibName: String? {
    return "MainWindowController"
  }

    override func windowDidLoad() {
        super.windowDidLoad()
      self.textField.delegate = self
      items.append("First Item")
      items.append("Second Item")
      updateUI()
    }
    
}
