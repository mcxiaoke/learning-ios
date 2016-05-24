//
//  ImageViewController.swift
//  ViewControl
//
//  Created by mcxiaoke on 16/5/23.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

class ImageViewController: NSViewController {
  
  weak var imageView: NSImageView?
  var image: NSImage?
  
  override func loadView() {
    
    self.view = NSView(frame: CGRectZero)
    self.view.translatesAutoresizingMaskIntoConstraints = false
    let imageView = NSImageView(frame:CGRectZero)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.imageScaling = NSImageScaling.ScaleProportionallyDown
    self.imageView = imageView
    self.view.addSubview(imageView)
    let constraint1 = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[imageView]-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["imageView":imageView])
    let constraint2 = NSLayoutConstraint.constraintsWithVisualFormat("V:|-[imageView]-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["imageView":imageView])
    NSLayoutConstraint.activateConstraints(constraint1)
    NSLayoutConstraint.activateConstraints(constraint2)
//    let top = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0.0)
//    let bottom = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0.0)
//    let leading = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0.0)
//    let trailing = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0.0)
//    NSLayoutConstraint.activateConstraints([top, bottom, leading, trailing])
    
  }

    override func viewDidLoad() {
        super.viewDidLoad()
      self.imageView?.image = image
    }
    
}
