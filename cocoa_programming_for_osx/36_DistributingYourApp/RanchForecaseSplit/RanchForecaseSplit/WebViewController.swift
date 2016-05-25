//
//  WebViewController.swift
//  RanchForecaseSplit
//
//  Created by mcxiaoke on 16/5/24.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa
import WebKit

class WebViewController: NSViewController {
  
  var webView: WKWebView {
    return view as! WKWebView
  }
  
  override func loadView() {
    let webView = WKWebView()
    webView.translatesAutoresizingMaskIntoConstraints = false
    view = webView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[webView]-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["webView": self.webView]))
  }
  
  func loadURL(url: NSURL) {
    print("loadURL: \(url)")
    let request = NSURLRequest(URL: url)
    webView.loadRequest(request)
  }
  
}
