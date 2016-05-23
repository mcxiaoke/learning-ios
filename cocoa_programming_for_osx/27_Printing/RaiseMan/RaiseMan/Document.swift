//
//  Document.swift
//  RaiseMan
//
//  Created by mcxiaoke on 16/4/29.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

class Document: NSDocument, NSWindowDelegate {
  
  @IBOutlet weak var tableView:NSTableView!
  @IBOutlet weak var arrayController:NSArrayController!
  
  private var KVOContext: Int = 0
  var employees: [Employee] = [] {
    willSet {
      for employee in employees {
        stopObservingEmployee(employee)
      }
    }
    
    didSet {
      for employee in employees {
        startObservingEmployee(employee)
      }
    }
  }
  
  @IBAction func addEmployee(sender:NSButton) {
    let windowController = windowControllers[0]
    let window = windowController.window!
    let endedEditing = window.makeFirstResponder(window)
    if !endedEditing {
      print("Unable to end editing.")
      return
    }
    let undo:NSUndoManager = undoManager!
    if undo.groupingLevel > 0 {
      undo.endUndoGrouping()
      undo.beginUndoGrouping()
    }
    let employee = arrayController.newObject() as! Employee
    arrayController.addObject(employee)
    arrayController.rearrangeObjects()
    let sortedEmployees = arrayController.arrangedObjects as! [Employee]
    let row = sortedEmployees.indexOf(employee)!
    print("starting edit of \(employee) in row \(row)")
    tableView.editColumn(0, row: row, withEvent: nil, select: true)
  }
  
  @IBAction func removeEmployees(sender:NSButton){
    let selectedPeople:[Employee] = arrayController.selectedObjects as! [Employee]
    let alert = NSAlert()
    let prefix = selectedPeople.count > 1 ? "these" : "this"
    let name = selectedPeople.count > 1 ? "people" : "person"
    alert.messageText = NSLocalizedString("REMOVE_MESSAGE", comment: "the remove alert's messageText")
//    alert.messageText = "Do you really want to remove \(prefix) \(name)?"
    let informativeFormat = NSLocalizedString("REMOVE_INFORMATIVE %d", comment: "the remove alert's informativeText")
    alert.informativeText = String(format: informativeFormat, selectedPeople.count)
//    alert.informativeText = "\(selectedPeople.count) \(name) will be removed."
    let removeButtonTitle = NSLocalizedString("REMOVE_DO", comment: "the remove alert's remove button")
    alert.addButtonWithTitle(removeButtonTitle)
    let removeKeepTitle = NSLocalizedString("REMOVE_KEEP", comment: "the remove alert's keep button")
    alert.addButtonWithTitle(removeKeepTitle)
    let removeCancelTitle = NSLocalizedString("REMOVE_CANCEL", comment: "the remove alert's cancel button")
    alert.addButtonWithTitle(removeCancelTitle)
    let window = sender.window!
    alert.beginSheetModalForWindow(window) { (response) in
      switch response {
      case NSAlertFirstButtonReturn:
        self.arrayController.remove(nil)
      case NSAlertSecondButtonReturn:
        selectedPeople.forEach({ (employee) in
          employee.raise = 0.0
        })
        self.tableView.reloadData()
      default: break
      }
    }
  }
  
  func windowWillClose(notification: NSNotification) {
    employees = []
  }

  override init() {
      super.init()
  }

  override class func autosavesInPlace() -> Bool {
    return true
  }

  override var windowNibName: String? {
    // Returns the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this property and override -makeWindowControllers instead.
    return "Document"
  }

  override func dataOfType(typeName: String) throws -> NSData {
    tableView.window?.endEditingFor(nil)
    return NSKeyedArchiver.archivedDataWithRootObject(employees)
  }

  override func readFromData(data: NSData, ofType typeName: String) throws {
    print("About to read data of type \(typeName)")
    employees = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! [Employee]
  }
  
  override func windowControllerDidLoadNib(windowController: NSWindowController) {
    super.windowControllerDidLoadNib(windowController)
  }
  
  // MARK: - Accessors
  func insertObject(employee:Employee, inEmployeesAtIndex index: Int) {
    print("adding \(employee) to the employees array")
    let undo: NSUndoManager = undoManager!
    undo.prepareWithInvocationTarget(self).removeObjectFromEmployeesAtIndex(employees.count)
    if !undo.undoing {
      undo.setActionName(NSLocalizedString("UNDO_ADD", comment: "undo action add person"))
    }
    employees.append(employee)
  }
  
  func removeObjectFromEmployeesAtIndex(index: Int) {
    let employee = employees[index]
    print("removing \(employee) from the employees array")
    let undo:NSUndoManager = undoManager!
    undo.prepareWithInvocationTarget(self).insertObject(employee, inEmployeesAtIndex: index)
    if !undo.undoing {
      undo.setActionName(NSLocalizedString("UNDO_REMOVE", comment: "undo action remove person"))
    }
    employees.removeAtIndex(index)
  }
  
  // MARK: KVO
  func startObservingEmployee(employee: Employee) {
    employee.addObserver(self, forKeyPath: "name", options: .Old, context: &KVOContext)
    employee.addObserver(self, forKeyPath: "raise", options: .Old, context: &KVOContext)
  }
  
  func stopObservingEmployee(employee:Employee) {
    employee.removeObserver(self, forKeyPath: "name", context: &KVOContext)
    employee.removeObserver(self, forKeyPath: "raise", context: &KVOContext)
  }
  
  override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
    //
    if context != &KVOContext {
      super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
      return
    }
    var oldValue: AnyObject? = change?[NSKeyValueChangeOldKey]
    if oldValue is NSNull {
      oldValue = nil
    }
    let undo:NSUndoManager = undoManager!
    print("oldValue = \(oldValue)")
    undo.prepareWithInvocationTarget(object!).setValue(oldValue, forKeyPath: keyPath!)
  }
  
  override func printOperationWithSettings(printSettings: [String : AnyObject]) throws -> NSPrintOperation {
    let employeesPrintingView = EmployeesPrintingView(employees: employees)
    let printInfo: NSPrintInfo = self.printInfo
    let printOperation = NSPrintOperation(view: employeesPrintingView, printInfo:printInfo)
    return printOperation
  }


}

