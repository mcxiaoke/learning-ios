//
//  PreferenceManager.swift
//  SpeakLine
//
//  Created by mcxiaoke on 16/5/4.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

private let activeVoiceKey = "activeVoice"
private let activeTextKey = "activeText"

class PreferenceManager {
  
  private let userDefaults = NSUserDefaults.standardUserDefaults()
  
  var activeVoice: String? {
    set {
      userDefaults.setObject(newValue, forKey: activeVoiceKey)
    }
    
    get {
      return userDefaults.objectForKey(activeVoiceKey) as? String
    }
  }
  
  var activeText:String? {
    set {
      userDefaults.setObject(newValue, forKey: activeTextKey)
    }
    
    get {
      return userDefaults.objectForKey(activeTextKey) as? String
    }
  }
  
  init() {
    registerDefaultPreferences()
  }
  
  func registerDefaultPreferences() {
    let defaults =
      [activeVoiceKey: NSSpeechSynthesizer.defaultVoice(),
       activeTextKey: "Able was I ere I saw Elba." ]
    userDefaults.registerDefaults(defaults)
  }
  
  func reset() {
    userDefaults.removeObjectForKey(activeVoiceKey)
    userDefaults.removeObjectForKey(activeTextKey)
  }
  
}
