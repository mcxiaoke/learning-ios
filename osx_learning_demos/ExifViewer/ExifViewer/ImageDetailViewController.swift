//
//  ViewController.swift
//  ExifViewer
//
//  Created by mcxiaoke on 16/5/25.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa


class ImageDetailViewController: NSViewController, NSTableViewDelegate {
  
  let saveProperties = NSMutableDictionary()
  
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
  dynamic var properties: [ImagePropertyItem] = []
  
  @IBOutlet weak var filePathLabel: NSTextField!
  @IBOutlet weak var fileSizeLabel: NSTextField!
  @IBOutlet weak var fileTypeLabel: NSTextField!
  @IBOutlet weak var filePixelLabel:NSTextField!
  @IBOutlet weak var tableView: NSTableView!
  @IBOutlet weak var arrayController: NSArrayController!
  
  func addChangedProperty(item: ImagePropertyItem, value:AnyObject?){
    let key = item.rawKey
    print("addChangedProperty: \(key)=\(value) Type:\(value.dynamicType)")
    if ExifPropertyKeys.contains(key){
      let exifDict = saveProperties[kCGImagePropertyExifDictionary as String] as? NSMutableDictionary ?? NSMutableDictionary()
      exifDict[key] = value
      saveProperties[kCGImagePropertyExifDictionary as String] = exifDict
    }else if GPSPropertyKeys.contains(key){
      let gpsDict = saveProperties[kCGImagePropertyGPSDictionary as String] as? NSMutableDictionary ?? NSMutableDictionary()
      gpsDict[key] = value
      saveProperties[kCGImagePropertyGPSDictionary as String] = gpsDict
    }else if ImagePropertyKeys.contains(key) {
      saveProperties[key] = value
    }
  }
  
  @IBAction func textValueDidChange(sender: NSTextField) {
    if let object = self.arrayController.selectedObjects.first as? ImagePropertyItem{
      let row  = self.tableView.selectedRow
      let objValue = ImagePropertyItem.getObjectValue(object, value: sender.stringValue)
      print("textValueDidChange row=\(row) obj=\(objValue) type=\(objValue.dynamicType)")
      addChangedProperty(object, value: objValue)
    }
//    print("textValueDidChange text = \(stringValue)")
  }
  
  func tableViewSelectionDidChange(notification: NSNotification) {
    if let object = self.arrayController.selectedObjects.first as? ImagePropertyItem{
      let row  = self.tableView.selectedRow
      //let view = self.tableView.viewAtColumn(1, row: row, makeIfNecessary: false)
      //if let textField = view?.subviews[0] as? NSTextField {
        //textField.editable = object.editable
      //}
      print("tableViewSelectionDidChange row =\(row) obj=\(object)")
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
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
      let image = ImageHelper.thumbFromImage(url)
      dispatch_async(dispatch_get_main_queue(), { 
        self.image = image
      })
    }
  }
  
  func loadImageProperties(url: NSURL){
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
      guard let imageSource = CGImageSourceCreateWithURL(url, nil) else { return }
      guard let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil) as Dictionary? else { return }
      guard let props  = imageProperties as? Dictionary<String,AnyObject> else { return }
      let width = props[kCGImagePropertyPixelWidth as String] as! Int
      let height = props[kCGImagePropertyPixelHeight as String] as! Int
      let properties = ImagePropertyItem.parse(props).sort { $0.key < $1.key }
      dispatch_async(dispatch_get_main_queue(), {
        self.filePixelLabel.stringValue = "\(width)X\(height)"
        self.properties = properties
      })
    }
  }
  
  func saveDocument(sender:AnyObject){
    saveDocumentAs(sender)
  }
  
  func saveDocumentAs(sender:AnyObject){
    print("saveDocumentAs")
    if let url = imageURL {
      writeProperties(url)
      saveProperties.removeAllObjects()
    }
  }
  
  func writeProperties(url:NSURL){
    if saveProperties.count == 0{
      return
    }
    let imageSource = CGImageSourceCreateWithURL(url, nil)
    if imageSource == nil {
      return
    }
    let uti = CGImageSourceGetType(imageSource!)!
    let data = NSMutableData()
    guard let imageDestination = CGImageDestinationCreateWithData(data, uti, 1, nil) else { return }
//    let gpsDict = [
//      kCGImagePropertyGPSDateStamp as String : "2016:05:08",
//      kCGImagePropertyGPSTimeStamp as String : "05:44:00",
//      kCGImagePropertyGPSLongitudeRef as String : "E",
//      kCGImagePropertyGPSLongitude as String : 108.389555,
//      kCGImagePropertyGPSLatitudeRef as String : "N",
//      kCGImagePropertyGPSLatitude as String : 22.785911666
//    ]
//    let metaDict = [kCGImagePropertyGPSDictionary as String : gpsDict]
    CGImageDestinationAddImageFromSource(imageDestination, imageSource!, 0, saveProperties)
    CGImageDestinationFinalize(imageDestination)
      
      let directory = NSSearchPathForDirectoriesInDomains(.DownloadsDirectory, .UserDomainMask, true).first!
      let newFileName = url.lastPathComponent!
      let writePath = NSURL(fileURLWithPath:directory).URLByAppendingPathComponent(newFileName)
              print("Image saved to \(writePath)")
              _ = try? data.writeToURL(writePath, options: NSDataWritingOptions.AtomicWrite)
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

