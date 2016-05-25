//
//  ViewController.swift
//  ExifViewer
//
//  Created by mcxiaoke on 16/5/25.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

class ExifInfo: NSObject{
  dynamic let key: String
  dynamic let value: AnyObject?
  
  init(key:String, value: AnyObject){
    self.key = key
    self.value = value
  }
}

class ViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
  
  @IBOutlet weak var label: NSTextField!
  @IBOutlet weak var tableView: NSTableView!
  
  var exifProperties: [ExifInfo] = []
  
  func numberOfRowsInTableView(tableView: NSTableView) -> Int {
    return exifProperties.count
  }
  
  func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
    return exifProperties[row]
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print("viewDidLoad")
  }
  
  @IBAction func openDocument(sender:AnyObject) {
    let panel = NSOpenPanel()
    panel.allowsMultipleSelection = false
    panel.canChooseDirectories = false
    panel.canCreateDirectories = false
    panel.canChooseFiles = true
    panel.beginWithCompletionHandler { (result) in
      if result == NSFileHandlingPanelOKButton {
        print("openDocument: \(panel.URLs )")
        self.parseExifInfo(panel.URLs.first!)
      }
    }
  }
  
  func createExifInfo(key:String, value:AnyObject, prefix:String = "") -> ExifInfo {
//    print("\(key)=\(value) Type:\(value.dynamicType)")
    let valueStr:String
    if let value2 = value as? NSArray {
      valueStr = value2.componentsJoinedByString(" ")
    }else {
      valueStr = "\(value)"
    }
    return ExifInfo(key: "\(prefix) \(key)", value: valueStr)
  }
  
  // https://github.com/oopww1992/WWimageExif
  // http://oleb.net/blog/2011/09/accessing-image-properties-without-loading-the-image-into-memory/
  // https://developer.apple.com/library/ios/documentation/GraphicsImaging/Reference/CGImageProperties_Reference/index.html
  // http://sandeepc.livejournal.com/656.html
  // CFDictionary can cast to Dictionary?
  // CFString can cast to String
  // http://stackoverflow.com/questions/32716146/cfdictionary-wont-bridge-to-nsdictionary-swift-2-0-ios9
  func parseExifInfo(url: NSURL){
    let imageSource = CGImageSourceCreateWithURL(url, nil)!
//    let imageOptions:[String:Bool] = [kCGImageSourceShouldCache as String: false]
//    if let imageTags = CGImageSourceCopyMetadataAtIndex(imageSource, 0, nil){
//      CGImageMetadataEnumerateTagsUsingBlock(imageTags, nil , nil, { (path, tag) in
//        let tagName = CGImageMetadataTagCopyName(tag)!
//        let tagValue = CGImageMetadataTagCopyValue(tag)!
//        print("[\(path)] [\(tagName)=\(tagValue)]")
//        return true
//      })
//    }
    if let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil) as Dictionary?{
      let exif = imageProperties[kCGImagePropertyExifDictionary as String]
      let gps = imageProperties[kCGImagePropertyGPSDictionary as String]
      let tiff = imageProperties[kCGImagePropertyTIFFDictionary as String]
      
      if gps == nil {
        print("No GPS Data!")
        let uti = CGImageSourceGetType(imageSource)!
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
        
        CGImageDestinationAddImageFromSource(imageDestination!, imageSource, 0, metaDict)
        CGImageDestinationFinalize(imageDestination!)
        
        let directory = NSSearchPathForDirectoriesInDomains(.DownloadsDirectory, .UserDomainMask, true).first!
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat="yyyyMMdd_HHmmss"
        let newFileName = "\(dateFormatter.stringFromDate(NSDate())).jpg"
        let writePath = NSURL(fileURLWithPath:directory).URLByAppendingPathComponent(newFileName)
        print("Image \(url) saved to \(writePath)")
//        _ = try? data.writeToURL(writePath, options: NSDataWritingOptions.AtomicWrite)
      }
      if let exif = exif as? Dictionary<String, AnyObject> {
        exif.forEach { (key,value) in
          self.exifProperties.append(createExifInfo(key, value: value, prefix: "EXIF"))
        }
      }
      if let gps = gps as? Dictionary<String, AnyObject> {
        gps.forEach { (key,value) in
          self.exifProperties.append(createExifInfo(key, value: value, prefix: "GPS"))
        }
      }
      if let tiff = tiff as? Dictionary<String, AnyObject> {
        tiff.forEach { (key,value) in
          self.exifProperties.append(createExifInfo(key, value: value, prefix: "TIFF"))
        }
      }
      
      self.tableView?.reloadData()
      self.label?.stringValue = url.path!
    }
    
  }


}

