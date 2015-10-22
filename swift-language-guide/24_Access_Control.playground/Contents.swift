//: Playground - noun: a place where people can play
// https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/AccessControl.html#//apple_ref/doc/uid/TP40014097-CH41-ID3

import UIKit

public class SomePublicClass {          // explicitly public class
  public var somePublicProperty = 0    // explicitly public class member
  var someInternalProperty = 0         // implicitly internal class member
  private func somePrivateMethod() {}  // explicitly private class member
}

class SomeInternalClass {               // implicitly internal class
  var someInternalProperty = 0         // implicitly internal class member
  private func somePrivateMethod() {}  // explicitly private class member
}

private class SomePrivateClass {        // explicitly private class
  var somePrivateProperty = 0          // implicitly private class member
  func somePrivateMethod() {}          // implicitly private class member
}

private func someFunction() -> (SomeInternalClass, SomePrivateClass) {
  // function implementation goes here
  return (SomeInternalClass(),SomePrivateClass())
}

public enum CompassPoint {
  case North
  case South
  case East
  case West
}

public class A {
  private func someMethod() {}
}

internal class B: A {
  override internal func someMethod() {
    super.someMethod()
  }
}

struct TrackedString {
  private(set) var numberOfEdits = 0
  var value: String = "" {
    didSet {
      numberOfEdits++
    }
  }
}

var stringToEdit = TrackedString()
stringToEdit.value = "This string will be tracked."
stringToEdit.value += " This edit will increment numberOfEdits."
stringToEdit.value += " So will this one."
print("The number of edits is \(stringToEdit.numberOfEdits)")
// prints "The number of edits is 3"

public struct TrackedString2 {
  public private(set) var numberOfEdits = 0
  public var value: String = "" {
    didSet {
      numberOfEdits++
    }
  }
  public init() {}
}


