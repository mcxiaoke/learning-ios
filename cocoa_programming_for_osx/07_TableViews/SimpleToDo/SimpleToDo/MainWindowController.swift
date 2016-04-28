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
  var curIndex = NSNotFound
  
  @IBOutlet weak var textField: NSTextField!
  @IBOutlet weak var tableView: NSTableView!
  @IBOutlet weak var addButton: NSButton!
  
  @IBAction func addItem(sender: AnyObject) {
    if curIndex != NSNotFound {
      self.items[curIndex] = self.textField.stringValue
    }else {
      self.items.append(self.textField.stringValue)
    }
    self.curIndex = NSNotFound
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
  
  func deleteRow(action:NSTableViewRowAction, row:Int) {
    //
  }
  
  // table view
  func numberOfRowsInTableView(tableView: NSTableView) -> Int {
    return items.count
  }
  
  func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
    return items[row]
  }
  
  
  func tableView(tableView: NSTableView, rowActionsForRow row: Int, edge: NSTableRowActionEdge) -> [NSTableViewRowAction] {
    let deleteAction = NSTableViewRowAction(style: NSTableViewRowActionStyle.Destructive, title: "Delete", handler: { action, row in
          print("action = \(action) row = \(row)")
    })
    return [deleteAction]
  }
  
  
  func tableViewSelectionDidChange(notification: NSNotification) {
    let row = self.tableView.selectedRow
    self.curIndex = row
    self.textField.stringValue = items[row]
  }
  
  override var windowNibName: String? {
    return "MainWindowController"
  }

    override func windowDidLoad() {
        super.windowDidLoad()
      self.textField.delegate = self
      for i in 1...10 {
        items.append("Simple ToDo List Item No.\(i)")
      }
      updateUI()
    }
    
}
