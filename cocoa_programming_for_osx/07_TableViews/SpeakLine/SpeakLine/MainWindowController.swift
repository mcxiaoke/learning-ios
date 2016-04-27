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
  
  
    override func windowDidLoad() {
        super.windowDidLoad()
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
