//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

let url = NSURL(string:"file:///Users/mcxiaoke/Pictures/20160508_054400164_iOS.jpg")!

print(url.path)

if let imageSource = CGImageSourceCreateWithURL(url, nil) {
  print(imageSource)
  let value = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil)!
  if let properties = value as? [NSObject:AnyObject] {
    properties.keys.map({ (key) -> String in
      "\(key)=\(properties[key])\n"
    }).joinWithSeparator(",")
  }

}else {
  print("no source")
}
