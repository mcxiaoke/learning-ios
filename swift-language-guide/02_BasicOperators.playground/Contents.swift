//: Playground - noun: a place where people can play
// https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/BasicOperators.html#//apple_ref/doc/uid/TP40014097-CH6-ID60
// http://wiki.jikexueyuan.com/project/swift/chapter2/02_Basic_Operators.html

import UIKit

let b = 10
var a = 5
a = b

let (x, y) = (1, 2)

//if x = y {
  // = return nothing
  // code
//}

"hello, " + "world"

9 % 4
-9 % 4
8 % 2.5
9 % 2.5

var i = 0
++i

var aa = 0
let bb = ++aa
let cc = aa++

let three = 3
let minusThree = -three
let plusThree = -minusThree

var a1 = 1
a1 += 2

let name = "world"
if name == "world" {
  print("hello, world")
}else{
  print("hello, nobody")
}

let contentHeight = 40
let hasHeader = true
let rowHeight = contentHeight + (hasHeader ? 50 : 20)

var aStr: String?
var bStr = "B String"
aStr ?? bStr
aStr != nil ? aStr! : bStr
aStr = "A String"
aStr ?? bStr
aStr != nil ? aStr! : bStr

let defaultColorName = "red"
var userDefinedColorName: String?  // default = nil
var colorNameToUse = userDefinedColorName ?? defaultColorName

for index in 1 ... 5 {
  print("\(index)*5 = \(index * 5)")
}

for index in 1 ..< 5 {
  print("\(index)*5 = \(index * 5)")
}

let names = ["Anna", "Alex", "Brian", "Jack"]
let count = names.count
for i in 0 ..< count {
  print("No.\(i+1) = \(names[i])")
}

let allowedEntry = false
if !allowedEntry {
  print("Access Denied")
}

let enteredDoorCode = true
let passedRetinaScan = false
if enteredDoorCode && passedRetinaScan {
  print("Welcome!")
}else{
  print("Access Denied")
}


let hasDoorKey = false
let knowsOverridePassword = true
if hasDoorKey || knowsOverridePassword {
  print("Welcome!")
}else{
  print("Access Denied")
}































