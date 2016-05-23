//
//  ScheduleFetcherTests.swift
//  RanchForecast
//
//  Created by mcxiaoke on 16/5/23.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import XCTest
import RanchForecast

class ScheduleFetcherTests: XCTestCase {
  
  var fetcher: ScheduleFetcher!
  
  override func setUp() {
    super.setUp()
    fetcher = ScheduleFetcher()
  }
  
  override func tearDown() {
    fetcher = nil
    super.tearDown()
  }
  
  func testCreateCourseFromValidDictionary(){
    let course: Course! = fetcher.courseFromDictionary(Constants.validCourseDict)
    XCTAssertNotNil(course)
    XCTAssertEqual(course.title, Constants.title)
    XCTAssertEqual(course.url, Constants.url)
    XCTAssertEqual(course.nextStartDate, Constants.date)
  }
  
  func testCreateCourseFromValidDictionarySafe(){
    let course: Course! = fetcher.courseFromDictionarySafe(Constants.validCourseDict)
    XCTAssertNotNil(course)
    XCTAssertEqual(course.title, Constants.title)
    XCTAssertEqual(course.url, Constants.url)
    XCTAssertEqual(course.nextStartDate, Constants.date)
  }
  
  func testResultFromValidHTTPResponseAndValidData(){
    let result = fetcher.resultFromData(Constants.jsonData, response: Constants.okResponse, error:nil)
    switch result {
    case .Success(let courses):
      XCTAssert(courses.count == 1)
      let theCourse = courses[0]
      XCTAssertEqual(theCourse.title, Constants.title)
      XCTAssertEqual(theCourse.url, Constants.url)
      XCTAssertEqual(theCourse.nextStartDate, Constants.date)
    default:
      XCTFail("Result contains Failure, but Success was expected.")
    }
  }
  
  func testResultFromInValidHTTPResponseAndNoData(){
    let result = fetcher.resultFromData(nil, response: Constants.errorResponse, error:nil)
    XCTAssertNotNil(result)
    switch result {
    case .Failure:
      print("")
    default:
      XCTFail("Result contains Success, but Failure was expected.")
    }
  }
  
  func testResultFromValidHTTPResponseAndInValidData(){
    let result = fetcher.resultFromData(Constants.invalidJsonData, response: Constants.okResponse, error:nil)
    XCTAssertNotNil(result)
    switch result {
    case .Failure:
      print("")
    default:
      XCTFail("Result contains Success, but Failure was expected.")
    }
  }


}
