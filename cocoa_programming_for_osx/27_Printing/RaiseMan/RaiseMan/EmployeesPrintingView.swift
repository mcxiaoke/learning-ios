//
//  EmployeesPrintingView.swift
//  RaiseMan
//
//  Created by mcxiaoke on 16/5/23.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

private let font: NSFont = NSFont.userFixedPitchFontOfSize(12.0)!
private let textAttributes: [String: AnyObject] = [NSFontAttributeName: font]
private let lineHeight: CGFloat = font.capHeight * 2.0

class EmployeesPrintingView: NSView {
  let employees: [Employee]
  var pageRect = NSRect()
  var linesPerPage: Int = 0
  var currentPage: Int = 0
  
  init(employees: [Employee]) {
    self.employees = employees
    super.init(frame: NSRect())
  }
  
  required init?(coder: NSCoder) {
    self.employees = []
    super.init(coder: coder)
    assertionFailure("cannot be instantiated from a nib")
  }
  
  override func knowsPageRange(range: NSRangePointer) -> Bool {
    let printOperation = NSPrintOperation.currentOperation()
    let printInfo: NSPrintInfo = (printOperation?.printInfo)!
    
    pageRect = printInfo.imageablePageBounds
    let newFrame = NSRect(origin: CGPoint(), size: printInfo.paperSize)
    frame = newFrame
    linesPerPage = Int(pageRect.height / lineHeight)
    var rangeOut = NSRange(location: 0, length: 0)
    rangeOut.location = 1
    rangeOut.length = employees.count / linesPerPage
    
    if employees.count % linesPerPage > 0 {
      rangeOut.length += 1
    }
    range.memory = rangeOut
    return true
  }
  
  override func rectForPage(page: Int) -> NSRect {
    currentPage = page - 1
    return pageRect
  }
  
  override var flipped: Bool{
    return true
  }
  
  override func drawRect(dirtyRect: NSRect) {
    var nameRect = NSRect(x: pageRect.minX, y: 0, width: 200.0, height: lineHeight)
    var raiseRect = NSRect(x: nameRect.maxX, y: 0, width: 100.0, height: lineHeight)
    
    for indexOnPage in 0..<linesPerPage {
      let indexInEmployees = currentPage * linesPerPage + indexOnPage
      if indexInEmployees >= employees.count {
        break
      }
      
      let employee = employees[indexInEmployees]
      nameRect.origin.y = pageRect.minY + CGFloat(indexOnPage) * lineHeight
      let employeeName = (employee.name ?? "")
      let indexAndName = "\(indexInEmployees) \(employeeName)" as NSString
      indexAndName.drawInRect(nameRect, withAttributes: textAttributes)
      
      raiseRect.origin.y = nameRect.minY
      let raise = String(format: "%4.1f%%", employee.raise * 100)
      let raiseString = raise as NSString
      raiseString.drawInRect(raiseRect, withAttributes: textAttributes)
    }
    
  }
  
  
  
  
  
  
  
  
  
  
  
}
