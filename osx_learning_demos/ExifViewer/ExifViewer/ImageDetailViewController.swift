//
//  ViewController.swift
//  ExifViewer
//
//  Created by mcxiaoke on 16/5/25.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

let categoriesTable:[String:String] = [
  kCGImagePropertyExifDictionary as String:"Exif",
  kCGImagePropertyExifAuxDictionary as String:"Exif Aux",
  kCGImagePropertyGPSDictionary as String:"GPS",
  kCGImagePropertyTIFFDictionary as String:"TIFF",
  kCGImagePropertyIPTCDictionary as String:"IPTC",
  kCGImagePropertyJFIFDictionary as String:"JFTF",
  kCGImagePropertyRawDictionary as String:"Raw",
  kCGImagePropertyDNGDictionary  as String:"DNG",
  kCGImagePropertyPNGDictionary as String:"PNG",
  kCGImagePropertyGIFDictionary  as String:"GIF",
  kCGImagePropertyMakerAppleDictionary  as String:"Apple",
  kCGImagePropertyMakerNikonDictionary  as String:"Nikon",
  kCGImagePropertyMakerCanonDictionary  as String:"Canon",
  kCGImagePropertyMakerFujiDictionary  as String:"Fuji",
  kCGImagePropertyMakerOlympusDictionary  as String:"Olympus",
  kCGImagePropertyMakerPentaxDictionary as String: "Pentax"
]
let imageIOBundle = NSBundle(identifier:"com.apple.ImageIO.framework")

class PropertyItem:NSObject {
  let key:String
  let value:String
  let cat:String?
  let rawKey:String
  let rawValue:AnyObject
  var rawCat:String?
  
  init(rawKey:String, rawValue:AnyObject, rawCat:String?){
    self.rawKey = rawKey
    self.rawValue = rawValue
    self.rawCat = rawCat
    self.key = PropertyItem.normalizeKey(rawKey, rawCat: rawCat)
    self.value = PropertyItem.normalizeValue(rawValue)
    if let rawCat = rawCat {
      self.cat = PropertyItem.getImageIOLocalizedString(rawCat)
    }else{
      self.cat = nil
    }
    super.init()
  }
  
  class func normalizeKey(rawKey: String, rawCat:String?) -> String {
    let key = getImageIOLocalizedString(rawKey)
    if let prefix = getCategoryPrefix(rawCat) {
      return "\(prefix) \(key)"
    }else {
      return key
    }
  }
  
  class func normalizeValue(value:AnyObject) -> String {
    let valueStr:String
    if let value = value as? NSArray {
      valueStr = value.componentsJoinedByString(", ")
    }else {
      valueStr = "\(value)"
    }
    return valueStr
  }
  
  class func getImageIOLocalizedString(key: String) -> String
  {
    return imageIOBundle?.localizedStringForKey(key, value: key, table: "CGImageSource") ?? key
  }
  
  class func getCategoryPrefix(category: String?) -> String? {
    if let category = category {
      if let prefix = categoriesTable[category]{
        return "\(prefix) "
      }
    }
    return nil
  }
}

class ImageInfo:NSObject {
  let fileName:String
  let width:Int = 0
  let height:Int = 0
  var properties:[[String:PropertyItem]] = []
  
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
      }else{
        self.image = nil
        self.arrayController.content = nil
      }
    }
  }
  
  dynamic var image:NSImage?
  dynamic var properties: [PropertyItem] = []
  
  @IBOutlet weak var filePathLabel: NSTextField!
  @IBOutlet weak var fileSizeLabel: NSTextField!
  @IBOutlet weak var fileTypeLabel: NSTextField!
  @IBOutlet weak var filePixelLabel:NSTextField!
  @IBOutlet weak var tableView: NSTableView!
  @IBOutlet weak var arrayController: NSArrayController!
  
  let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
  
  @IBAction func textValueChanged(sender: NSTextField) {
    print("textValueChanged: \(sender.stringValue)")
    if let object = self.arrayController.selectedObjects.first {
      let row  = self.tableView.selectedRow
      print("outlineViewSelectionDidChange selectedRow = \(row)")
      print("outlineViewSelectionDidChange selectedObject = \(object)")
    }
  }
  
  func outlineViewSelectionDidChange(notification: NSNotification) {
    if let object = self.arrayController.selectedObjects.first {
      let row  = self.tableView.selectedRow
      print("outlineViewSelectionDidChange selectedRow = \(row)")
      print("outlineViewSelectionDidChange selectedObject = \(object)")
    }
  }
  
  
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
  
  func parseProperties(properties: Dictionary<String,AnyObject>, category:String? = nil) -> [PropertyItem]{
    var items:[PropertyItem] = []
    properties.forEach { (key, value) in
      if let child  = value as? Dictionary<String,AnyObject> {
        items += parseProperties(child, category: key)
      }else {
        let newItem = PropertyItem(rawKey: key, rawValue: value, rawCat: category)
        items.append(newItem)
      }
    }
    return items
  }
  
  func loadImageProperties(url: NSURL){
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
      if let imageSource = CGImageSourceCreateWithURL(url, nil) {
        if let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil) as Dictionary?{
          let width = imageProperties[kCGImagePropertyPixelWidth] as! Int
          let height = imageProperties[kCGImagePropertyPixelHeight] as! Int
          if let imageProperties  = imageProperties as? Dictionary<String,AnyObject> {
            let properties = self.parseProperties(imageProperties).sort { $0.key < $1.key }
              dispatch_async(dispatch_get_main_queue(), {
                self.filePixelLabel.stringValue = "\(width)X\(height)"
                self.properties = properties
              })
          }
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

