//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

//XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

let text = "【喷嚏图卦20160629】半小时就结束了排练，其他演员看完都深感惭愧"
let range = NSRange(location: 0, length: (text as NSString).length)
let pattern = "【(\\w+)(\\d{8})】(.*)"
let regex = try! NSRegularExpression(pattern: pattern, options: [])
let result = regex.firstMatchInString(text, options: [], range: range)
print(result?.rangeAtIndex(0))
print(result?.rangeAtIndex(1))
(text as NSString).substringWithRange(result!.rangeAtIndex(1))
(text as NSString).substringWithRange(result!.rangeAtIndex(2))
(text as NSString).substringWithRange(result!.rangeAtIndex(3))


//let url = NSURL(string: "http://www.dapenti.com/blog/blog.asp?subjectid=70&name=xilei")!
//
//NSURLSession.sharedSession().dataTaskWithURL(url) {
//  data, response, error in
//  if let data = data {
//    let string = NSString(data: data!, encoding: NSUTF8StringEncoding)
//  }
//  print("Got result: \(string)")
//  XCPlaygroundPage.currentPage.finishExecution()
//  }.resume()
