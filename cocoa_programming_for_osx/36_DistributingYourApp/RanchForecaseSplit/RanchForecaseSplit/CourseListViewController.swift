//
//  CourseListViewController.swift
//  RanchForecaseSplit
//
//  Created by mcxiaoke on 16/5/24.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

protocol CourseListViewControllerDelegate: class {
  func courseListViewController(viewController: CourseListViewController,
                                selectedCourse: Course?) -> Void
}

class CourseListViewController: NSViewController {
  
  weak var delegate: CourseListViewControllerDelegate? = nil

  dynamic var courses: [Course] = []
  
  let fetcher = ScheduleFetcher()
  
  @IBOutlet var arrayController: NSArrayController!
  
  @IBAction func selectCourse(sender: AnyObject){
    let selectedCourse = arrayController.selectedObjects.first as? Course
    delegate?.courseListViewController(self, selectedCourse: selectedCourse)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print("CourseListViewController loaded")
    fetcher.fetchCoursesUsingCompletionHandler { (result) -> (Void) in
      switch result {
      case .Success(let courses):
        #if DEBUG
          print("Got courses: \(courses)")
        #else
          print("Got courses")
        #endif
        self.courses = courses
      case .Failure(let error):
        print("Got error: \(error)")
        NSAlert(error: error!).runModal()
        self.courses = []
      }
    }
  }
}
