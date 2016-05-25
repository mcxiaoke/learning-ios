//
//  MainSplitViewController.swift
//  RanchForecaseSplit
//
//  Created by mcxiaoke on 16/5/24.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

class MainSplitViewController: NSSplitViewController,
  CourseListViewControllerDelegate{
  
  var masterViewController: CourseListViewController {
    return splitViewItems[0] .viewController as! CourseListViewController
  }
  
  var detailViewController: WebViewController {
    return splitViewItems[1] .viewController as! WebViewController
  }
  
  let defaultUrl = NSURL(string: "http://www.bignerdranch.com/")!

  override func viewDidLoad() {
    super.viewDidLoad()
    print("MainSplitViewController loaded")
    masterViewController.delegate = self
    detailViewController.loadURL(defaultUrl)
  }
  
  func courseListViewController(viewController: CourseListViewController, selectedCourse: Course?) {
    if let course = selectedCourse {
      detailViewController.loadURL(course.url)
    }else {
      detailViewController.loadURL(defaultUrl)
    }
  }
    
}
