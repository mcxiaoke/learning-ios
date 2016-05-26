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
}

// 左侧图片列表的VC
class ImageListViewController: NSViewController {

  @IBOutlet weak var label:NSTextField!
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
    print("selectedObjects: \(arrayController.selectedObjects)")
    let selectedURL = arrayController.selectedObjects.first as? NSURL
    delegate?.imageListViewController(self, selectedURL: selectedURL)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.selectImageURL(self)
  }
  
}
