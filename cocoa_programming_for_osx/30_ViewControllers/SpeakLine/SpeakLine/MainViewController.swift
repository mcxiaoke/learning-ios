//
//  MainViewController.swift
//  SpeakLine
//
//  Created by mcxiaoke on 16/5/23.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController,
  NSSpeechSynthesizerDelegate,
  NSWindowDelegate,
  NSTableViewDelegate,
  NSTableViewDataSource{
  
  @IBOutlet weak var textField:NSTextField!
  @IBOutlet weak var speakButton:NSButton!
  @IBOutlet weak var stopButton:NSButton!
  let voices = NSSpeechSynthesizer.availableVoices()
  let speaker = NSSpeechSynthesizer()
  var isStarted:Bool = false {
    didSet {
      updateUI()
    }
  }
  
  
  @IBOutlet weak var tableView: NSTableView!
  
  
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
    textField.editable = !isStarted
  }
  
  func speechSynthesizer(sender: NSSpeechSynthesizer, willSpeakWord characterRange: NSRange, ofString string: String) {
    print("range: \(characterRange)")
    let attributedString = NSMutableAttributedString(string: string)
    let pastRange = NSRange(location: 0, length: characterRange.location)
    attributedString.addAttribute(NSForegroundColorAttributeName, value: NSColor.greenColor(), range: pastRange)
    attributedString.addAttribute(NSForegroundColorAttributeName, value: NSColor.redColor(), range: characterRange)
    textField.attributedStringValue = attributedString as NSAttributedString
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
  
  func voiceNameForIdentifier( identifier:String) -> String? {
    return NSSpeechSynthesizer.attributesForVoice(identifier)[NSVoiceName] as? String
  }
  
  // mark: tableView
  func numberOfRowsInTableView(tableView: NSTableView) -> Int {
    return voices.count
  }
  
  func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
    return voiceNameForIdentifier(voices[row])
  }
  
  func tableViewSelectionDidChange(notification: NSNotification) {
    let row = tableView.selectedRow
    speaker.setVoice(row == -1 ? nil : voices[row])
  }
  
  override var nibName: String?{
    return "MainViewController"
  }

  override func viewDidLoad() {
      super.viewDidLoad()
      updateUI()
      self.speaker.delegate = self
      let defaultVoice = NSSpeechSynthesizer.defaultVoice()
      print("default voice is \(voiceNameForIdentifier(defaultVoice))")
      if let defaultRow = voices.indexOf(defaultVoice) {
        let row = voices.startIndex.distanceTo(defaultRow)
        print("default row is \(row)")
        let indices = NSIndexSet(index:row)
        tableView.selectRowIndexes(indices, byExtendingSelection: false)
        tableView.scrollRowToVisible(row)
      }
    }
    
}
