//
//  ViewController.swift
//  ExifViewer
//
//  Created by mcxiaoke on 16/5/25.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

class ExifInfo {
  let key:String
  let value:AnyObject?
  
  init(key:String, value:AnyObject?){
    self.key = key
    self.value = value
  }
}

class ImageInfo {
  let fileName:String
  let width:Int = 0
  let height:Int = 0
  var properties:[[String:ExifInfo]] = []
  
  init(fileName: String){
    self.fileName = fileName
  }
}

class ImageDetailViewController: NSViewController, NSOutlineViewDelegate {
  
  var imageURL:NSURL? {
    didSet {
      if let url = imageURL {
        loadFileInfo(url)
        loadImageThumb(url)
        loadImageProperties(url)
      }
    }
  }
  
  dynamic var image:NSImage?
  dynamic var properties:[NSDictionary]?
  
  @IBOutlet weak var filePathLabel: NSTextField!
  @IBOutlet weak var fileSizeLabel: NSTextField!
  @IBOutlet weak var fileTypeLabel: NSTextField!
  @IBOutlet weak var outlineView: NSOutlineView!
  @IBOutlet weak var treeController: NSTreeController!
  
  let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
  
  func loadFileInfo(url:NSURL){
    self.filePathLabel.stringValue = url.lastPathComponent!
    if let attrs = try? NSFileManager.defaultManager().attributesOfItemAtPath(url.path!){
//      print("attrs = \(attrs)")
      self.fileSizeLabel.objectValue = attrs[NSFileSize]
      self.fileTypeLabel.objectValue = attrs[NSFileCreationDate]
    }
  }
  
  func loadImageThumb(url:NSURL){
    dispatch_async(queue) { 
      let image = self.thumbImageFromImage(url)
      dispatch_async(dispatch_get_main_queue(), { 
        self.image = image
      })
    }
  }
  
  func thumbImageFromImage(url: NSURL) -> NSImage {
    let image = NSImage(contentsOfURL: url)!
    let targetHeight: CGFloat = 160.0
    let imageSize = image.size
    let smallerSize = NSSize(width: targetHeight * imageSize.width / imageSize.height, height: targetHeight)
    return NSImage(size: smallerSize, flipped: false) { (rect) -> Bool in
      image.drawInRect(rect)
      return true
    }
  }
  
  func normalizeValue(value:AnyObject) -> String {
    let valueStr:String
    if let value2 = value as? NSArray {
      valueStr = value2.componentsJoinedByString(", ")
    }else {
      valueStr = "\(value)"
    }
    return valueStr
  }
  
  func ImageIOLocalizedString(key: String) -> String
  {
    let bundle = NSBundle(identifier:"com.apple.ImageIO.framework")
    return bundle?.localizedStringForKey(key, value: key, table: "CGImageSource") ?? key
  }
  
  func parseToTree(properties: NSDictionary) -> [NSDictionary]{
    let keys = properties.allKeys.sort { (left, right) -> Bool in
      return (left as! String) < (right as! String)
    }
    var array:[NSDictionary] = []
    for i in 1..<keys.count {
      let key = keys[i] as! String
      let locKey = ImageIOLocalizedString(key)
      let obj = properties.objectForKey(key)!
      let child: NSDictionary
      if let obj = obj as? NSDictionary {
        child =  ["key": locKey, "value":"", "children": self.parseToTree(obj)]
      }else{
        child =  ["key": locKey, "value": normalizeValue(obj)]
      }
//      array.addObject(child)
      array.append(child)
    }
    return array
  }
  
  func loadImageProperties(url: NSURL){
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
      if let imageSource = CGImageSourceCreateWithURL(url, nil) {
        if let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil) as Dictionary?{
          let width = imageProperties[kCGImagePropertyPixelWidth] as! Int
          let height = imageProperties[kCGImagePropertyPixelHeight] as! Int
          print("Image width=\(width) height=\(height)")
          
          let properties = self.parseToTree(imageProperties)
          dispatch_async(dispatch_get_main_queue(), {
            self.properties = properties
            self.outlineView.expandItem(nil, expandChildren: true)
            //      let exif = imageProperties[kCGImagePropertyExifDictionary as String]
            //      let gps = imageProperties[kCGImagePropertyGPSDictionary as String]
            //      let tiff = imageProperties[kCGImagePropertyTIFFDictionary as String]
          })
        }
      }
    }
  }
  
  func writeProperties(url:NSURL){
    let imageSource = CGImageSourceCreateWithURL(url, nil)
    if imageSource == nil {
      return
    }
    let uti = CGImageSourceGetType(imageSource!)!
    let data = NSMutableData()
    let imageDestination = CGImageDestinationCreateWithData(data, uti, 1, nil)
    
    if imageDestination == nil {
      return
    }
    
    let gpsDict = [
      kCGImagePropertyGPSDateStamp as String : "2016:05:08",
      kCGImagePropertyGPSTimeStamp as String : "05:44:00",
      kCGImagePropertyGPSLongitudeRef as String : "E",
      kCGImagePropertyGPSLongitude as String : 108.389555,
      kCGImagePropertyGPSLatitudeRef as String : "N",
      kCGImagePropertyGPSLatitude as String : 22.785911666
    ]
    let metaDict = [kCGImagePropertyGPSDictionary as String : gpsDict]
    
    CGImageDestinationAddImageFromSource(imageDestination!, imageSource!, 0, metaDict)
    CGImageDestinationFinalize(imageDestination!)
      
//      let directory = NSSearchPathForDirectoriesInDomains(.DownloadsDirectory, .UserDomainMask, true).first!
//      let dateFormatter = NSDateFormatter()
//      dateFormatter.dateFormat="yyyyMMdd_HHmmss"
//      let newFileName = "\(dateFormatter.stringFromDate(NSDate())).jpg"
//      let writePath = NSURL(fileURLWithPath:directory).URLByAppendingPathComponent(newFileName)
      //        print("Image \(url) saved to \(writePath)")
      //        _ = try? data.writeToURL(writePath, options: NSDataWritingOptions.AtomicWrite)
  }
  
  // https://github.com/oopww1992/WWimageExif
  // http://oleb.net/blog/2011/09/accessing-image-properties-without-loading-the-image-into-memory/
  // https://developer.apple.com/library/ios/documentation/GraphicsImaging/Reference/CGImageProperties_Reference/index.html
  // http://sandeepc.livejournal.com/656.html
  // http://stackoverflow.com/questions/4169677/
  // CFDictionary can cast to Dictionary?
  // CFString can cast to String
  // http://stackoverflow.com/questions/32716146/cfdictionary-wont-bridge-to-nsdictionary-swift-2-0-ios9


}

