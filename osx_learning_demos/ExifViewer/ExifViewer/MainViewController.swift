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

  override func viewDidLoad() {
    super.viewDidLoad()
    self.imageListViewController.delegate = self
  }
  
  func imageListViewController(viewController: ImageListViewController, selectedURL: NSURL?) {
    print("selectedURL: \(selectedURL)")
    self.imageDetailViewController.imageURL = selectedURL
  }
  
  func imageListViewController(viewController: ImageListViewController, removedURLs: [NSURL]) {
    self.imageDetailViewController.imageURL = nil
  }
  
  @IBAction func openDocument(sender:AnyObject) {
    self.showOpenPanel()
  }
  
  func showOpenPanel(){
    let panel = NSOpenPanel()
    panel.allowsMultipleSelection = false
    panel.canChooseDirectories = true
    panel.canCreateDirectories = false
    panel.canChooseFiles = false
    panel.beginWithCompletionHandler { (result) in
      if result != NSFileHandlingPanelOKButton {
        return
      }
      
      guard let rootURL = panel.URL else { return }
      let fm = NSFileManager.defaultManager()
      var fileUrls: [NSURL] = []
      if rootURL.isTypeDirectory() {
        do {
          let directoryContents = try fm.contentsOfDirectoryAtURL(rootURL,
            includingPropertiesForKeys: nil, options: [.SkipsHiddenFiles, .SkipsSubdirectoryDescendants])
          fileUrls = directoryContents.filter({ (url) -> Bool in
            return url.isTypeRegularFile() && ImageExtensions.contains(url.pathExtension?.lowercaseString ?? "")
          })
        } catch let error as NSError {
          print(error.localizedDescription)
        }
      }
      //      print("showOpenPanel: \(fileUrls)")
      self.imageListViewController.urls = fileUrls
      self.imageListViewController.directory = rootURL
    }
  }
    
}
