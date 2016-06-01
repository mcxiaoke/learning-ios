//
//  ImageDetailTabViewController.swift
//  ExifViewer
//
//  Created by mcxiaoke on 16/6/1.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

class ImageDetailTabViewController: NSTabViewController {

  var imageURL:NSURL?
  var properties:[ImagePropertyItem]?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    for i in 0..<3 {
      let controller = TabInfoViewController()
      controller.title = "Tab \(i)"
      controller.properties = self.properties
      self.addChildViewController(controller)
    }
  }
    
}
