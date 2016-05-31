/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import Cocoa

let fileSystemRootURL = NSURL.fileURLWithPath("/", isDirectory: true)

class ViewController: NSViewController {
  
  @IBOutlet weak var tableView:NSTableView!
  
  @IBOutlet weak var statusLabel:NSTextField!
  
  let sizeFormatter = NSByteCountFormatter()
  var directory:Directory?
  var directoryItems:[Metadata]?
  var sortOrder = Directory.FileOrder.Name
  var sortAscending = true
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.setDelegate(self)
    tableView.setDataSource(self)
    tableView.target = self
    tableView.doubleAction = #selector(tableViewDoubleClick(_:))
    
    // 1
    let descriptorName = NSSortDescriptor(key: Directory.FileOrder.Name.rawValue, ascending: true)
    let descriptorDate = NSSortDescriptor(key: Directory.FileOrder.Date.rawValue, ascending: true)
    let descriptorSize = NSSortDescriptor(key: Directory.FileOrder.Size.rawValue, ascending: true)
    
    // 2
    tableView.tableColumns[0].sortDescriptorPrototype = descriptorName;
    tableView.tableColumns[1].sortDescriptorPrototype = descriptorDate;
    tableView.tableColumns[2].sortDescriptorPrototype = descriptorSize;
    
    statusLabel.stringValue = ""
  }
  
  var rootURL: NSURL? {
    return representedObject as? NSURL
  }
  
  override var representedObject: AnyObject? {
    didSet {
      if let url = representedObject as? NSURL {
        directory = Directory(folderURL:url)
        reloadFileList()
      }
    }
  }
  
  @IBAction func revealSelectedButtonClick(sender:AnyObject){
    let row = tableView.rowForView(sender as! NSView)
    if let item = directoryItems?[row] {
      NSWorkspace.sharedWorkspace().selectFile(item.url.path, inFileViewerRootedAtPath: "")
    }
  }
  
  func tableViewDoubleClick(sender:AnyObject){
    guard tableView.selectedRow >= 0,
      let item = directoryItems?[tableView.selectedRow] else { return }
    // ignore current directory item click
    guard tableView.selectedRow != 1 else { return }
    print("tableViewDoubleClick: \(item.url)")
    if item.isFolder {
      self.representedObject = item.url
    }else {
      NSWorkspace.sharedWorkspace().openURL(item.url)
    }
  }
  
  func reloadDirectoryItems(){
    directoryItems = directory?.contentsOrderedBy(sortOrder, ascending: sortAscending)
    guard let currentURL = self.rootURL else { return }
    if let firstItem = Metadata.create(fileURL: currentURL, withName: ".") {
      directoryItems?.insert(firstItem, atIndex: 0)
    }
    guard let parentURL = currentURL.URLByDeletingLastPathComponent else { return }
    guard fileSystemRootURL != currentURL else { return }
    if let firstItem = Metadata.create(fileURL: parentURL, withName: "..") {
      directoryItems?.insert(firstItem, atIndex: 0)
    }
  }
  
  func reloadFileList(){
    reloadDirectoryItems()
    tableView.reloadData()
    updateStatus()
  }
  
  func updateStatus(){
    guard let rootURL = self.rootURL else { return }
    guard let rootPath = rootURL.path else { return }
    let text:String
    let itemsSelected = tableView.selectedRowIndexes.count
    if directoryItems == nil {
      text = ""
    }else if itemsSelected == 0 {
      text = "\(directoryItems!.count) items in \(rootPath)"
    }else if itemsSelected == 1 {
      text = directoryItems?[tableView.selectedRow].url.path ?? "ERROR"
    } else {
      text = "\(itemsSelected) of \(directoryItems!.count) selected"
    }
    statusLabel.stringValue = text
    self.view.window?.title = "File Viewer " + rootPath
  }
  
}

extension ViewController : NSTableViewDataSource {
  
  func numberOfRowsInTableView(tableView: NSTableView) -> Int {
    return directoryItems?.count ?? 0
  }
  
  func tableView(tableView: NSTableView, sortDescriptorsDidChange oldDescriptors: [NSSortDescriptor]) {
    guard let sortDescriptor = tableView.sortDescriptors.first else { return }
    if let order = Directory.FileOrder(rawValue: sortDescriptor.key!) {
      sortOrder = order
      sortAscending = sortDescriptor.ascending
    }
    reloadFileList()
  }

}

extension ViewController: NSTableViewDelegate {
  
  func tableViewSelectionDidChange(notification: NSNotification) {
    updateStatus()
  }
  
  func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
    
    var image:NSImage?
    var text = ""
    var cellIdentifier = ""
    
    guard let item = directoryItems?[row] else { return nil }
    
    if tableColumn == tableView.tableColumns[0] {
      image = item.icon
      text = item.name
      cellIdentifier = "NameCell"
    }else if tableColumn == tableView.tableColumns[1] {
      text = item.date.description
      cellIdentifier = "DateCell"
    }else if tableColumn == tableView.tableColumns[2] {
      text = item.isFolder ? "--" : sizeFormatter.stringFromByteCount(item.size)
      cellIdentifier = "SizeCell"
    }else if tableColumn == tableView.tableColumns[3] {
      cellIdentifier = "ActionCell"
    }
    
    if let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as? NSTableCellView {
      cell.textField?.stringValue = text
      cell.imageView?.image = image
      return cell
    }
    
    return nil
  }
  
}












