//
//  GeneratePassword.swift
//  RandomPassword
//
//  Created by mcxiaoke on 16/4/25.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Foundation

private let characters = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()_-"

func generateRandomCharacter() -> Character{
  let index = Int(arc4random_uniform(UInt32(characters.characters.count)))
  let character:Character = characters[characters.startIndex.advancedBy(index)]
  return character
}

func generateRandomString(length:Int) -> String {
  var string = ""
  for _ in 0..<length {
    string.append(generateRandomCharacter())
  }
  return string
}