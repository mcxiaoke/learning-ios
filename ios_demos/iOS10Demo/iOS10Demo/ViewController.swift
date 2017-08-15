//
//  ViewController.swift
//  iOS10Demo
//
//  Created by mcxiaoke on 16/7/16.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import UIKit
import CallKit

let identifier = "com.mcxiaoke.iOS10Demo.CallKitDemo"

class ViewController: UIViewController {
  

  @IBAction func reloadClick(_ sender: AnyObject) {
    NSLog("reloadClick")
    CXCallDirectoryManager.sharedInstance.reloadExtension(withIdentifier: identifier) { (error) in
        NSLog("reloadExtension complete. \(error?.localizedDescription)")
    }
    CXCallDirectoryManager.sharedInstance.getEnabledStatusForExtension(withIdentifier: identifier) { (status, error) in
      NSLog("getEnabledStatusForExtension complete. \(status) \(error?.localizedDescription)")
    }
  }


}

