//: Playground - noun: a place where people can play
// https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ClassesAndStructures.html#//apple_ref/doc/uid/TP40014097-CH13-ID82
// http://wiki.jikexueyuan.com/project/swift/chapter2/09_Classes_and_Structures.html

import UIKit

class SomeClass {
 // code
}
SomeClass.self

struct SomeStructure {
  // code
}
SomeStructure.self

struct Resolution {
  var width = 0
  var height = 0
}

class VideoMode {
  var resolution = Resolution()
  var interlaced = false
  var frameRate = 0.0
  var name: String?
}

let someResolution = Resolution()
let someVideoMode = VideoMode()
someResolution.dynamicType
someVideoMode.dynamicType

print("The width of someResolution is \(someResolution.width)")
print("The width of someVideoMode is \(someVideoMode.resolution.width)")

someVideoMode.resolution.width = 1280
someVideoMode.resolution.height = 720

let vga = Resolution(width: 640, height: 480)
print("vga resolution is \(vga)")

let hd = Resolution(width: 1920, height: 1080) //value type
var cinema = hd
cinema.width = 2048

print("cinema is now \(cinema.width) pixels wide")
print("hd is still \(hd.width) pixels wide")

enum CompassPoint {
  case North, South, East, West
}
var currentDirection = CompassPoint.West // value type
let rememberedDirection = currentDirection
currentDirection = .East
if rememberedDirection == .West {
  print("The remembered direction is still .West")
}

let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0

print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
print("The frameRate property of alsoTenEighty is now \(alsoTenEighty.frameRate)")

tenEighty === alsoTenEighty




































