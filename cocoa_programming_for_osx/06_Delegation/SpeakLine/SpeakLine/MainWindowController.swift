//
//  MainWindowController.swift
//  SpeakLine
//
//  Created by mcxiaoke on 16/4/27.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController,
        NSSpeechSynthesizerDelegate,
        NSWindowDelegate{
  
  @IBOutlet weak var textField:NSTextField!
  @IBOutlet weak var speakButton:NSButton!
  @IBOutlet weak var stopButton:NSButton!
  
  let speaker = NSSpeechSynthesizer()
  var isStarted:Bool = false {
    didSet {
      updateUI()
    }
  }
  
  @IBAction func speakIt(sender:NSButton) {
    let string = textField.stringValue
    if string.isEmpty {
      print("string is empty")
    }else {
      speaker.startSpeakingString(string)
      isStarted = true
    }
  }
  
  @IBAction func stopIt(sender:NSButton) {
    speaker.stopSpeaking()
  }
  
  func updateUI(){
    speakButton.enabled = !isStarted
    stopButton.enabled = isStarted
  }
  
  func speechSynthesizer(sender: NSSpeechSynthesizer, didFinishSpeaking finishedSpeaking: Bool) {
    isStarted = false
    print("finishedSpeaking = \(finishedSpeaking)")
  }
  
  func windowShouldClose(sender: AnyObject) -> Bool {
    return !isStarted
  }
  
  func windowWillResize(sender: NSWindow, toSize frameSize: NSSize) -> NSSize {
    print("frameSize is \(frameSize.width) wide and \(frameSize.height) tall")
    return frameSize
  }

  override var windowNibName: String? {
    return "MainWindowController"
  }
  
  
    override func windowDidLoad() {
        super.windowDidLoad()
        self.speaker.delegate = self
        updateUI()
    }
    
}
