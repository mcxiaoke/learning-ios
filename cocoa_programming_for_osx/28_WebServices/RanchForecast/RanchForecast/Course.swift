//
//  Course.swift
//  RanchForecast
//
//  Created by mcxiaoke on 16/5/23.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Foundation

class Course: NSObject {
  let title:String
  let url:NSURL
  let nextStartDate: NSDate
  
  init(title: String, url: NSURL, nextStartDate: NSDate) {
    self.title = title
    self.url = url
    self.nextStartDate = nextStartDate
    super.init()
  }
  
  override var description: String {
    return "Course(title:\(title) url:\(url))"
  }
}
