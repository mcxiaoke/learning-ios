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

class ViewController: NSViewController {
  
  dynamic var image: NSImage?
  
  @IBOutlet weak var label: NSTextField!
  @IBOutlet weak var outlineView: NSOutlineView!
  @IBOutlet weak var treeController: NSTreeController!
  
  var exifProperties: [ExifInfo] = []
  
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
      if result != NSFileHandlingPanelOKButton {
        return
      }
      print("openDocument: \(panel.URLs )")
      if let url = panel.URLs.first {
        self.parseExifInfo(url)
        let globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        dispatch_async(globalQueue) {
          let thumb = self.thumbImageFromImage(NSImage(contentsOfURL:url)!)
          dispatch_async(dispatch_get_main_queue()){
            self.image = thumb
          }
        }
      }
    }
  }
  
  func thumbImageFromImage(image: NSImage) -> NSImage {
    let targetHeight: CGFloat = 160.0
    let imageSize = image.size
    let smallerSize = NSSize(width: targetHeight * imageSize.width / imageSize.height, height: targetHeight)
    return NSImage(size: smallerSize, flipped: false) { (rect) -> Bool in
      image.drawInRect(rect)
      return true
    }
  }
  
  func createExifInfo(key:String, value:AnyObject, prefix:String = "") -> ExifInfo {
    return ExifInfo(key: "\(prefix) \(key)", value: normalizeValue(value))
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
  
  class func ImageIOLocalizedString(key: String) -> String
  {
    let bundle = NSBundle(identifier:"com.apple.ImageIO.framework")
    return bundle?.localizedStringForKey(key, value: key, table: "CGImageSource") ?? key
  }
  
  func parseToTree(properties: NSDictionary) -> NSArray{
    let keys = properties.allKeys.sort { (left, right) -> Bool in
      return (left as! String) < (right as! String)
    }
    let array = NSMutableArray()
    for i in 1..<keys.count {
      let key = keys[i] as! String
      let locKey = ViewController.ImageIOLocalizedString(key)
      let obj = properties.objectForKey(key)!
      let child: NSDictionary
      if let obj = obj as? NSDictionary {
        child =  ["key": locKey, "value":"", "children": self.parseToTree(obj)]
      }else{
        child =  ["key": locKey, "value": normalizeValue(obj)]
      }
      array.addObject(child)
    }
    return array
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
      let tree = parseToTree(imageProperties)
      self.treeController.content = tree
      self.outlineView.expandItem(nil, expandChildren: true)
      
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
      
      var properties: [ExifInfo] = []
      if let exif = exif as? Dictionary<String, AnyObject> {
        exif.forEach { (key,value) in
          properties.append(createExifInfo(key, value: value, prefix: "EXIF"))
        }
      }
      if let gps = gps as? Dictionary<String, AnyObject> {
        gps.forEach { (key,value) in
          properties.append(createExifInfo(key, value: value, prefix: "GPS"))
        }
      }
      if let tiff = tiff as? Dictionary<String, AnyObject> {
        tiff.forEach { (key,value) in
          properties.append(createExifInfo(key, value: value, prefix: "TIFF"))
        }
      }
      
      self.exifProperties = properties
//      self.exifProperties = properties.sort({ (a, b) -> Bool in
//        return a.key < b.key
//      })
//      self.tableView?.reloadData()
      self.label?.stringValue = url.path!
    }
    
  }


}

