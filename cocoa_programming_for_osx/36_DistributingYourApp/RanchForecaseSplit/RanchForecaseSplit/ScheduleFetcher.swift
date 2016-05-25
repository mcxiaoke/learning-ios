//
//  ScheduleFetcher.swift
//  RanchForecast
//
//  Created by mcxiaoke on 16/5/23.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Foundation

public class ScheduleFetcher {
  
  public enum FetchCourseResult {
    case Success([Course])
    case Failure(NSError?)
  }
  
  let session: NSURLSession
  
  public init(){
    let config = NSURLSessionConfiguration.defaultSessionConfiguration()
    session = NSURLSession(configuration: config)
  }
  
  public func errorWithCode(code: Int, localizedDescription: String) -> NSError {
    return NSError(domain: "ScheduleFetcher", code: code, userInfo: [NSLocalizedDescriptionKey: localizedDescription])
  }
  
  public func courseFromDictionary(courseDict: NSDictionary) -> Course? {
    let title = courseDict["title"] as! String
    let urlString = courseDict["url"] as! String
    let upcomingArray = courseDict["upcoming"] as! [NSDictionary]
    let nextUpcomingDict = upcomingArray.first!
    let nextStartDateString = nextUpcomingDict["start_date"] as! String
    let url = NSURL(string: urlString)!
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let nextStartDate = dateFormatter.dateFromString(nextStartDateString)!
    return Course(title: title, url: url, nextStartDate: nextStartDate)
  }
  
  public func courseFromDictionarySafe(courseDict: NSDictionary) -> Course? {
    if let title = courseDict["title"] as? String,
      let urlString = courseDict["url"] as? String,
      let upcomingArray = courseDict["upcoming"] as? [NSDictionary],
      let nextUpcomingDict = upcomingArray.first,
      let nextStartDateString = nextUpcomingDict["start_date"] as? String{
        let url = NSURL(string: urlString)!
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let nextStartDate = dateFormatter.dateFromString(nextStartDateString)!
        return Course(title: title, url: url, nextStartDate: nextStartDate)
    }
    return nil
  }
  
  public func resultFromData(data: NSData?, response: NSURLResponse?, error: NSError?) -> FetchCourseResult {
    if data == nil || response == nil {
      return .Failure(error)
    }
    
    var result: FetchCourseResult
    do {
      if data == nil {
        result = .Failure(error!)
      }else if let response = response as? NSHTTPURLResponse{
        print("Received \(data!.length) bytes, HTTP \(response.statusCode) \(NSHTTPURLResponse.localizedStringForStatusCode(response.statusCode))")
        if response.statusCode == 200 {
          if let topLevelDict = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary {
            let courseDicts = topLevelDict["courses"] as! [NSDictionary]
            var courses: [Course] = []
            for courseDict in courseDicts {
              if let course = courseFromDictionarySafe(courseDict) {
                courses.append(course)
              }
            }
            result =  .Success(courses)
          }else {
            result = .Failure(errorWithCode(1, localizedDescription: "Unexpected parse error"))
          }
        }else {
          let error = self.errorWithCode(1, localizedDescription: "Bad status code \(response.statusCode)")
          result = .Failure(error)
        }
      }else {
        let error = self.errorWithCode(1, localizedDescription: "Unexpected response object.")
        result = .Failure(error)
      }
    } catch let error as NSError{
      result = .Failure(error)
    }
    return result
  }
  
  public func fetchCoursesUsingCompletionHandler(completionHandler: (FetchCourseResult) -> (Void)) {
    // http://bookapi.bignerdranch.com/courses.xml
    let url = NSURL(string: "http://bookapi.bignerdranch.com/courses.json")!
    let requst = NSURLRequest(URL: url)
    let task = session.dataTaskWithRequest(requst) { (data, response, error) in
      let result: FetchCourseResult = self.resultFromData(data, response: response, error: error)
      NSOperationQueue.mainQueue().addOperationWithBlock({ completionHandler(result)})
    }
    task.resume()
  }

  
}