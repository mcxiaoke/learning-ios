//
//  NerdTabViewController.swift
//  ViewControl
//
//  Created by mcxiaoke on 16/5/24.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

class NerdTabViewController2: NSViewController {
  
  var box = NSView()
  var buttons:[NSButton] = []
  
  func selectTabAtInex(index:Int){
    assert(index < childViewControllers.count, "index out of range")
    for (i, button) in buttons.enumerate() {
      button.state = (index == i) ? NSOnState : NSOffState
    }
    let viewController = childViewControllers[index]
    box.subviews = []
    box.addSubview(viewController.view)
  }
  
  func selectTab(sender: NSButton) {
    let index = sender.tag
    selectTabAtInex(index)
  }
  
  
  override func loadView() {
    view  = NSView()
    reset()
  }
  
  func reset(){
    view.subviews = []
    let buttonWidth: CGFloat = 28
    let buttonHeight: CGFloat = 28
    
    let viewControllers = childViewControllers
    buttons = viewControllers.enumerate().map({ (index, viewController) -> NSButton in
      let button = NSButton()
      button.setButtonType(.ToggleButton)
      button.translatesAutoresizingMaskIntoConstraints = false
      button.bordered = false
      button.target = self
      button.action = #selector(selectTab(_:))
      button.tag = index
      
      if let viewController = viewController as? ImageRepresentable {
        button.image = viewController.image
      }else{
        button.title = viewController.title!
      }
      NSLayoutConstraint.activateConstraints([
        NSLayoutConstraint(item: button, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: buttonWidth),
        NSLayoutConstraint(item: button, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: buttonHeight)
        ])
      return button
    })
    
    let stackView = NSStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.orientation = .Horizontal
    stackView.spacing = 4
    buttons.forEach { stackView.addView($0, inGravity: .Center) }
    
    box.translatesAutoresizingMaskIntoConstraints = false
    
    let separator = NSBox()
    separator.boxType = .Separator
    separator.translatesAutoresizingMaskIntoConstraints = false
    
    view.subviews = [stackView, separator, box]
    
    let views = ["stack": stackView, "separator":separator, "box": box]
    let metrics = ["buttonHeight": buttonHeight]
    
    func addVFLConstraints(vfl: String){
      NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat(vfl, options: NSLayoutFormatOptions(rawValue:0), metrics: metrics, views: views))
    }
    
    addVFLConstraints("H:|[stack]|")
    addVFLConstraints("H:|[separator]|")
    addVFLConstraints("H:|[box(>=200)]|")
    addVFLConstraints("V:|[stack(buttonHeight)][separator(==1)][box(>=200)]|")
    
    if childViewControllers.count > 0 {
      selectTabAtInex(0)
    }
    
    
  }
  
  override func insertChildViewController(childViewController: NSViewController, atIndex index: Int) {
    super.insertChildViewController(childViewController, atIndex: index)
    if viewLoaded {
      reset()
    }
  }
  
  override func removeChildViewControllerAtIndex(index: Int) {
    super.removeChildViewControllerAtIndex(index)
    if viewLoaded {
      reset()
    }
  }
}
