//
//  ViewController.swift
//  Scattered
//
//  Created by mcxiaoke on 16/5/24.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
  
  let processingQueue: NSOperationQueue = {
    let result = NSOperationQueue()
    result.maxConcurrentOperationCount = 4
    return result
  }()
  
  var textLayer: CATextLayer!
  
  var text: String? {
    didSet {
      let font = NSFont.systemFontOfSize(textLayer.fontSize)
      let attributes = [NSFontAttributeName: font]
      var size = text?.sizeWithAttributes(attributes) ?? CGSize.zero
      size.width = ceil(size.width)
      size.height = ceil(size.height)
      textLayer.bounds = CGRect(origin: CGPoint.zero, size: size)
      textLayer.superlayer?.bounds = CGRect(x: 0, y: 0, width: size.width + 16, height: size.height + 20)
      textLayer.string = text
    }
  }
  
  func thumbImageFromImage(image: NSImage) -> NSImage {
    let targetHeight: CGFloat = 200.0
    let imageSize = image.size
    let smallerSize = NSSize(width: targetHeight * imageSize.width / imageSize.height, height: targetHeight)
    let smallerImage = NSImage(size: smallerSize, flipped: false) { (rect) -> Bool in
      image.drawInRect(rect)
      return true
    }
    return smallerImage
  }
  
  func presentImage(image: NSImage, fileName:String) {
    let superLayerBounds = view.layer!.bounds
    let center = CGPoint(x: superLayerBounds.midX, y: superLayerBounds.midY)
    let imageBounds = CGRect(origin: CGPoint.zero, size: image.size)
    let randomPoint = CGPoint(x: CGFloat(arc4random_uniform(UInt32(superLayerBounds.maxX))),
                              y: CGFloat(arc4random_uniform(UInt32(superLayerBounds.maxY))))
    let timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    let positionAnimation = CABasicAnimation()
    positionAnimation.fromValue = NSValue(point: center)
    positionAnimation.duration = 2
    positionAnimation.timingFunction = timingFunction
    
    let boundsAnimation = CABasicAnimation()
    boundsAnimation.fromValue = NSValue(rect: CGRect.zero)
    boundsAnimation.duration = 2
    boundsAnimation.timingFunction = timingFunction
    
    let layer = CALayer()
    layer.contents = image
    layer.actions = [
      "position" : positionAnimation,
      "bounds" : boundsAnimation
    ]
    
    let nameLayer = CATextLayer()
    let font = NSFont.systemFontOfSize(12)
    let attributes = [NSFontAttributeName: font]
    var size = fileName.sizeWithAttributes(attributes) ?? CGSize.zero
    size.width = ceil(size.width)
    size.height = ceil(size.height)
    nameLayer.fontSize = 12
    nameLayer.position = randomPoint
    nameLayer.zPosition = 0
    nameLayer.bounds = CGRect(origin: CGPoint.zero, size: size)
    nameLayer.foregroundColor = NSColor.redColor().CGColor
    nameLayer.string = fileName
    layer.addSublayer(nameLayer)
    
    CATransaction.begin()
    view.layer!.addSublayer(layer)
    layer.position = randomPoint
    layer.bounds = imageBounds
    CATransaction.commit()
  }
  
  func addImagesFromFolderURL(folderURL: NSURL) {
    processingQueue.addOperationWithBlock {
      let t0 = NSDate.timeIntervalSinceReferenceDate()
      let fileManager = NSFileManager()
      let directoryEnumerator = fileManager.enumeratorAtURL(folderURL, includingPropertiesForKeys: nil, options: NSDirectoryEnumerationOptions.SkipsHiddenFiles, errorHandler: nil)!
      while let url = directoryEnumerator.nextObject() as? NSURL {
        var isDirectoryValue: AnyObject?
        _ = try? url.getResourceValue(&isDirectoryValue, forKey: NSURLIsDirectoryKey)
        if let isDirectory = isDirectoryValue as? NSNumber
          where isDirectory.boolValue == false {
          
          self.processingQueue.addOperationWithBlock{
            let image = NSImage(contentsOfURL:url)
            if let image = image {

              let thumbImage = self.thumbImageFromImage(image)
              var fileNameValue: AnyObject?
              _ = try? url.getResourceValue(&fileNameValue, forKey: NSURLNameKey)
              if let fileName = fileNameValue as? String {
                print("fileName: \(fileName)")
                NSOperationQueue.mainQueue().addOperationWithBlock{
                  self.presentImage(thumbImage, fileName: fileName)
                  let t1 = NSDate.timeIntervalSinceReferenceDate()
                  let interval = t1 - t0
                  self.text = String(format: "%0.1fs", interval)
                }
              }
            }
          }
        }
      }
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.layer = CALayer()
    view.wantsLayer = true
    
    let tc = CALayer()
    tc.anchorPoint = CGPoint.zero
    tc.position = CGPointMake(10, 10)
    tc.zPosition = 100
    tc.backgroundColor = NSColor.blackColor().CGColor
    tc.borderColor = NSColor.whiteColor().CGColor
    tc.borderWidth = 2
    tc.cornerRadius = 15
    tc.shadowOpacity = 0.5
    view.layer!.addSublayer(tc)
    
    let tl = CATextLayer()
    tl.anchorPoint = CGPoint.zero
    tl.position = CGPointMake(10, 6)
    tl.zPosition = 100
    tl.fontSize = 24
    tl.foregroundColor = NSColor.whiteColor().CGColor
    self.textLayer = tl
    
    tc.addSublayer(tl)
    
    text = "Loading..."
    
    let url = NSURL(fileURLWithPath: "/Library/Desktop Pictures")
    addImagesFromFolderURL(url)
    
    
  }



}

