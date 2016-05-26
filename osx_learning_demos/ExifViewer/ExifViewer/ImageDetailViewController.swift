//
//  ImageDetailViewController.swift
//  ExifViewer
//
//  Created by mcxiaoke on 16/5/26.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

// 右侧图片EXIF信息的VC
class ImageDetailViewController: NSViewController {
  
  @IBOutlet weak var label: NSTextField!
  
  var imageURL:NSURL? {
    didSet {
      self.label.stringValue = imageURL?.path ?? ""
      showImageInfo(imageURL)
    }
  }
  
  func showImageInfo(url:NSURL?){
    //
  }
    
}
