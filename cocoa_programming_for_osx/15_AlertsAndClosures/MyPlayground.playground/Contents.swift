//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

let alert = NSAlert()
alert.messageText = "Alert message."
alert.informativeText = "A more detailed description of the situation."
alert.addButtonWithTitle("Default")
alert.addButtonWithTitle("Alternative")
alert.addButtonWithTitle("Other")
let result = alert.runModal()

let say = { (text:String) -> Void in
  print("The closure says: \(text)")
}

say("Hello")