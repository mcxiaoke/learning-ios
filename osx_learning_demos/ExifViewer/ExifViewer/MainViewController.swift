//
//  MainViewController.swift
//  ExifViewer
//
//  Created by mcxiaoke on 16/5/26.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

class MainViewController: NSSplitViewController, ImageListViewControllerDelegate {
  
  var imageListViewController: ImageListViewController  {
    return splitViewItems[0].viewController as! ImageListViewController
  }
  
  var imageDetailViewController: ImageDetailViewController {
    return splitViewItems[1].viewController as! ImageDetailViewController
  }
  
  @IBAction func openDocument(sender:AnyObject) {
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
      print("openDocument: \(fileUrls)")
      self.imageListViewController.urls = fileUrls
      self.imageListViewController.directory = fileRoot
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.imageListViewController.delegate = self
  }
  
  func imageListViewController(viewController: ImageListViewController, selectedURL: NSURL?) {
    print("selectedURL: \(selectedURL)")
    self.imageDetailViewController.imageURL = selectedURL
  }
    
}
