//
//  Course.swift
//  RanchForecast
//
//  Created by mcxiaoke on 16/5/23.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Foundation

public class Course: NSObject {
  public let title:String
  public let url:NSURL
  public let nextStartDate: NSDate
  
  public init(title: String, url: NSURL, nextStartDate: NSDate) {
    self.title = title
    self.url = url
    self.nextStartDate = nextStartDate
    super.init()
  }
  
  override public var description: String {
    return "Course(title:\(title) url:\(url))"
  }

}

public func ==(lhs: Course, rhs: Course) -> Bool {
  return lhs.title == rhs.title
    && lhs.url == rhs.url
    && lhs.nextStartDate == rhs.nextStartDate
}