//
//  MainWindowController.swift
//  RanchForecast
//
//  Created by mcxiaoke on 16/5/23.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
  @IBOutlet var spinner: NSProgressIndicator!
  @IBOutlet var scrollView: NSScrollView!
  @IBOutlet var tableView: NSTableView!
  @IBOutlet var arrayController: NSArrayController!
  
  let fetcher = ScheduleFetcher()
  dynamic var courses: [Course] = []
  
  override var windowNibName: String? {
    return "MainWindowController"
  }
  
  func openClass(sender: AnyObject!) {
    if let course = arrayController.selectedObjects.first as? Course {
      NSWorkspace.sharedWorkspace().openURL(course.url)
    }
  }
  
  func showProgress(){
    scrollView.hidden = true
    spinner.hidden = false
    spinner.indeterminate = true
    spinner.startAnimation(nil)
  }
  
  func showContent() {
    scrollView.hidden = false
    spinner.stopAnimation(nil)
    spinner.hidden = true
  }

    override func windowDidLoad() {
        super.windowDidLoad()
      tableView.target = self
      tableView.doubleAction = #selector(openClass(_:))

      fetcher.fetchCoursesUsingCompletionHandler { (result) -> (Void) in
        switch result {
        case .Success(let courses):
          print("Got courses: \(courses)")
          self.courses = courses
          self.showContent()
        case .Failure(let error):
          print("Got error: \(error)")
          NSAlert(error: error).runModal()
          self.courses = []
          self.showContent()
        }
      }
      showProgress()
    }
    
}
