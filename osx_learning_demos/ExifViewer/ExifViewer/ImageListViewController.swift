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
  
  var detailViewController: DetailTabViewController?
  
  @IBAction func selectImageURL(sender: AnyObject){
//    print("selectedObjects: \(arrayController.selectedObjects)")
    let selectedURL = arrayController.selectedObjects.first as? NSURL
    self.delegate?.imageListViewController(self, selectedURL: selectedURL)
  }
  
  @IBAction func modifySelectedImages(sender:AnyObject){
    let selectedURLs = arrayController.selectedObjects
//    let alert = NSAlert()
//    alert.messageText = "Modify Exif"
//    alert.informativeText = "you selected \(selectedURLs.count) images"
//    alert.runModal()
//    alert.beginSheetModalForWindow(self.view.window!) { (response) in
//      //
//    }
    self.presentViewControllerAsModalWindow(GPSEditViewController())
  }
  
  @IBAction func addImages(sender: AnyObject){
    if let mvc = self.parentViewController as? MainViewController {
      mvc.showOpenPanel()
    }
  }
  
  @IBAction func removeImages(sender: AnyObject){
    if let selectedImages = self.arrayController.selectedObjects as? [NSURL] {
      self.arrayController.removeObjects(selectedImages)
      self.delegate?.imageListViewController(self, removedURLs: selectedImages)
    }
  }
  
  @IBAction func doubleClickRow(sender:AnyObject){
    print("doubleClickRow")
    if let _ = self.arrayController.selectedObjects.first as? NSURL {
      self.performSegueWithIdentifier("showDetail", sender: nil)
    }
  }
  
  @IBAction override func selectAll(sender: AnyObject?) {
    self.tableView.selectAll(nil)
  }
  
  override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
    print("prepareForSegue: \(segue.identifier)")
    if let controller = segue.destinationController as? DetailTabViewController {
      if let imageURL = self.arrayController.selectedObjects.first as? NSURL {
          controller.imageURL = imageURL
      }
    }
  }
  
}
