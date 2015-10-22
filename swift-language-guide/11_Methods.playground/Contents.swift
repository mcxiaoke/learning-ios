//: Playground - noun: a place where people can play
// https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Methods.html#//apple_ref/doc/uid/TP40014097-CH15-ID234
// http://wiki.jikexueyuan.com/project/swift/chapter2/11_Methods.html

import UIKit

class Counter {
  var count = 0
  func increment(){
    ++count
  }
  
  func incrementBy(amount: Int){
    count += amount
  }
  
  func reset() {
    count = 0
  }
}

let counter = Counter()
counter.self
counter.dynamicType
counter.increment()
counter.count
counter.incrementBy(5)
counter.count
counter.reset()
counter.count

// mutating make self mutable
struct Point {
  var x = 0.0, y = 0.0
  mutating func moveByX(deltaX:Double, y deltaY:Double){
    x += deltaX
    y += deltaY
  }
}

var somePoint = Point(x: 1.0, y: 1.0)
somePoint.moveByX(2.0, y: 3.0)
print("The point is now at (\(somePoint.x), \(somePoint.y))")

let fixedPoint = Point(x: 3.0, y: 3.0)
// fixedPoint.moveByX(2.0, y: 3.0) // let, error

struct ThePoint {
  var x = 0.0, y = 0.0
  mutating func moveByX(deltaX:Double, y deltaY: Double) {
    self = ThePoint(x:x+deltaX, y:y+deltaY)
  }
}

var somePoint2 = ThePoint(x: 1.0, y: 1.0)
somePoint2.moveByX(2.0, y: 3.0)
print("The point is now at (\(somePoint2.x), \(somePoint2.y))")

enum TriStateSwitch {
  case Off, Low, High
  mutating func next() {
    switch self {
    case Off:
      self = Low
    case Low:
      self = High
    case High:
      self = Off
    }
  }
}
var ovenLight = TriStateSwitch.Low
ovenLight.next()
// ovenLight is now equal to .High
ovenLight.next()
// ovenLight is now equal to .Off

class SomeClass {
  class func someTypeMethod() {
    print("type method implementation goes here")
  }
}

SomeClass.someTypeMethod()

struct LevelTracker {
  static var highestUnlockedLevel = 1
  static func unlockLevel(level: Int) {
    if level > highestUnlockedLevel { highestUnlockedLevel = level }
  }
  static func levelIsUnlocked(level: Int) -> Bool {
    return level <= highestUnlockedLevel
  }
  var currentLevel = 1
  mutating func advanceToLevel(level: Int) -> Bool {
    if LevelTracker.levelIsUnlocked(level) {
      currentLevel = level
      return true
    } else {
      return false
    }
  }
}

class Player {
  var tracker = LevelTracker()
  let playerName: String
  func completedLevel(level: Int) {
    LevelTracker.unlockLevel(level + 1)
    tracker.advanceToLevel(level + 1)
  }
  init(name: String) {
    playerName = name
  }
}

var player = Player(name: "Argyrios")
player.completedLevel(1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")

player = Player(name: "Beto")
if player.tracker.advanceToLevel(6) {
  print("player is now on level 6")
} else {
  print("level 6 has not yet been unlocked")
}
// prints "level 6 has not yet been unlocked"







































