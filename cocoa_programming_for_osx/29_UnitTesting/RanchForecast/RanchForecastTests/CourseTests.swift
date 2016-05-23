//
//  CourseTests.swift
//  RanchForecast
//
//  Created by mcxiaoke on 16/5/23.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//
// http://stackoverflow.com/questions/31335486/xcode-test-not-detect-my-class
import RanchForecast

import XCTest

class CourseTests: XCTestCase {
  
  func testCourseInitialization(){
    let course = Course(title:  Constants.title,
                        url: Constants.url,
                        nextStartDate: Constants.date)
    XCTAssertEqual(course.title, Constants.title)
    XCTAssertEqual(course.url, Constants.url)
    XCTAssertEqual(course.nextStartDate, Constants.date)
  }
  
}
