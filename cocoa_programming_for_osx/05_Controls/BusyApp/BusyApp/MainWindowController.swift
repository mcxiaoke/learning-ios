//
//  MainWindowController.swift
//  BusyApp
//
//  Created by mcxiaoke on 16/4/27.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
  
  var lastSliderValue = 0.0
  
  @IBOutlet weak var slider: NSSlider!
  @IBOutlet weak var sliderLabel: NSTextField!
  
  
  @IBOutlet weak var secretText: NSSecureTextField!
  
  @IBOutlet weak var normalText: NSTextField!
  
  @IBOutlet weak var showMarkButton: NSButton!
  @IBOutlet weak var hideMarkButton: NSButton!
  
  @IBOutlet weak var resetButton: NSButton!
  
  @IBOutlet weak var checkBox: NSButton!
  
  
  @IBOutlet weak var revealButton: NSButton!
  
  @IBAction func sliderValueChanged(sender: NSSlider) {
    
    if sender.doubleValue > lastSliderValue {
      self.sliderLabel.stringValue = "Slider goes up!"
    }else if sender.doubleValue < lastSliderValue {
      self.sliderLabel.stringValue = "Slider goes down!"
    }
    
    lastSliderValue = sender.doubleValue
  }
  
  
  @IBAction func showCheck(sender: NSButton) {
    if sender.state == NSOnState {
      hideMarkButton.state = NSOffState
    }else {
      hideMarkButton.state = NSOnState
    }
    updateSlider()
    
  }
  
  @IBAction func hideCheck(sender: NSButton) {
    if sender.state == NSOnState {
      showMarkButton.state = NSOffState
    }else {
      showMarkButton.state = NSOnState
    }
    updateSlider()
  }
  
  @IBAction func checkMe(sender: NSButton) {
    updateCheckBox()
  }
  
  @IBAction func onResetClicked(sender: NSButton) {
    resetControls()
  }
  
  
  @IBAction func onRevealClicked(sender: NSButton) {
    self.normalText.stringValue = self.secretText.stringValue
  }
  
  func updateCheckBox() {
    if self.checkBox.state == NSOnState {
      self.checkBox.title = "Uncheck me"
    }else {
      self.checkBox.title = "Check me"
    }
  }
  
  func updateSlider() {
    if showMarkButton.state == NSOnState {
      self.slider.numberOfTickMarks = Int(slider.maxValue)/10
    }else {
      self.slider.numberOfTickMarks = 0
    }
    
  }
  
  func resetControls() {
    self.slider.doubleValue = self.slider.minValue
    self.showMarkButton.state = NSOnState
    self.hideMarkButton.state = NSOffState
    self.checkBox.state = NSOnState
    self.secretText.stringValue = ""
    self.secretText.placeholderString = "Type in a secret message"
    self.normalText.stringValue = ""
    updateSlider()
    updateCheckBox()
  }
  
  
  override var windowNibName: String? {
    return "MainWindowController"
  }

    override func windowDidLoad() {
        super.windowDidLoad()
        resetControls()
    }
    
}
