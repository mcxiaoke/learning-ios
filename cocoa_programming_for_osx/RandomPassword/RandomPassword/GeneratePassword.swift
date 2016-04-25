//
//  GeneratePassword.swift
//  RandomPassword
//
//  Created by mcxiaoke on 16/4/25.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Foundation

private let chars = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
private let specialChars = "~!@#$%^&*()_+-=[];,./{}|:<>?"

func generateRandomCharacter(special:Bool) -> Character{
  let total = chars.characters.count + (special ? specialChars.characters.count : 0)
  let index = Int(arc4random_uniform(UInt32(total)))
  let allChars = chars+(special ? specialChars : "")
  let character:Character = allChars[allChars.startIndex.advancedBy(index)]
  return character
}

func generateRandomString(length:Int, special:Bool) -> String {
  var string = ""
  for _ in 0..<length {
    string.append(generateRandomCharacter(special))
  }
  return string
}