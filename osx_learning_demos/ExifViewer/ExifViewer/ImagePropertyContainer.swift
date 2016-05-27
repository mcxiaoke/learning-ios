//
//  ImagePropertyContainer.swift
//  ExifViewer
//
//  Created by mcxiaoke on 16/5/27.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Foundation

class ImagePropertyContainer {
  let url:NSURL
  let fileName:String
  var size:Int?
  var createdAt:NSDate?
  var type:String?
  var dimension:(Int,Int)?
  var properties:[ImagePropertyItem] = []
  
  init(url:NSURL){
    self.url = url
    self.fileName = url.lastPathComponent!
    if let attrs = try? NSFileManager.defaultManager().attributesOfItemAtPath(url.path!){
      if let size = attrs[NSFileSize] as? NSNumber {
        self.size = size.integerValue
      }
      if let date = attrs[NSFileCreationDate] as? NSDate{
        self.createdAt = date
      }
    }
    
  }
  

}