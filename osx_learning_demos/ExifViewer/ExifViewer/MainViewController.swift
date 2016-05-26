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
//    print("selectedURL: \(selectedURL)")
    self.imageDetailViewController.imageURL = selectedURL
  }
    
}
