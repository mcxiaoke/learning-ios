//
//  ImageListViewController.swift
//  ExifViewer
//
//  Created by mcxiaoke on 16/5/26.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

protocol ImageListViewControllerDelegate: class {
  func imageListViewController(viewController: ImageListViewController,
                                selectedURL: NSURL?) -> Void
  
  func imageListViewController(viewController: ImageListViewController,
                               removedURLs: [NSURL]) -> Void
}

// 左侧图片列表的VC
class ImageListViewController: NSViewController, NSMenuDelegate {

  @IBOutlet weak var label:NSTextField!
  @IBOutlet weak var button: NSButton!
  @IBOutlet weak var tableView: NSTableView!
  @IBOutlet weak var arrayController: NSArrayController!
  
  dynamic var directory: NSURL? {
    didSet {
      self.label.stringValue = directory?.path ?? ""
    }
  }
  dynamic var urls:[NSURL] = []
  
  weak var delegate: ImageListViewControllerDelegate? = nil
  
  @IBAction func selectImageURL(sender: AnyObject){
//    print("selectedObjects: \(arrayController.selectedObjects)")
    let selectedURL = arrayController.selectedObjects.first as? NSURL
    self.delegate?.imageListViewController(self, selectedURL: selectedURL)
  }
  
  @IBAction func modifySelectedImages(sender:AnyObject){
    let selectedURLs = arrayController.selectedObjects
    let alert = NSAlert()
    alert.messageText = "Modify Exif"
    alert.informativeText = "you selected \(selectedURLs.count) images"
    alert.runModal()
//    alert.beginSheetModalForWindow(self.view.window!) { (response) in
//      //
//    }
  }
  
  @IBAction func addImages(sender: AnyObject){
    self.showOpenPanel()
  }
  
  @IBAction func removeImages(sender: AnyObject){
    if let selectedImages = self.arrayController.selectedObjects as? [NSURL] {
      self.arrayController.removeObjects(selectedImages)
      self.delegate?.imageListViewController(self, removedURLs: selectedImages)
    }
  }
  
  @IBAction func openDocument(sender:AnyObject) {
    self.showOpenPanel()
  }
  
  func showOpenPanel(){
    let panel = NSOpenPanel()
    panel.allowsMultipleSelection = true
    panel.canChooseDirectories = true
    panel.canCreateDirectories = false
    panel.canChooseFiles = true
    panel.beginWithCompletionHandler { (result) in
      if result != NSFileHandlingPanelOKButton {
        return
      }
      let fm = NSFileManager.defaultManager()
      let urls = panel.URLs
      let url = urls.first!
      var fileRoot: NSURL = url.URLByDeletingLastPathComponent!
      var fileUrls: [NSURL] = urls.filter {$0.isTypeRegularFile() }
      if urls.count == 1 {
        if url.isTypeDirectory() {
          do {
            let directoryContents = try fm.contentsOfDirectoryAtURL(url,
              includingPropertiesForKeys: nil, options: [.SkipsHiddenFiles, .SkipsSubdirectoryDescendants])
            fileUrls = directoryContents.filter {$0.isTypeRegularFile() }
            fileRoot = url
          } catch let error as NSError {
            print(error.localizedDescription)
          }
        }
      }
//      print("showOpenPanel: \(fileUrls)")
      self.urls += fileUrls
      self.directory = fileRoot
    }
  }
  
  func hello(sender:AnyObject){
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    self.tableView.menu = 
  }
  
}
