//: Playground - noun: a place where people can play
// https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Generics.html#//apple_ref/doc/uid/TP40014097-CH26-ID179

import UIKit

func swapTwoInts(inout a: Int, inout _ b: Int) {
  let temporaryA = a
  a = b
  b = temporaryA
}

var someInt2 = 3
var anotherInt2 = 107
swapTwoInts(&someInt2, &anotherInt2)
print("someInt is now \(someInt2), and anotherInt is now \(anotherInt2)")

func swapTwoValues<T>(inout a:T, inout _ b: T){
  let temp = a
  a = b
  b = temp
}

var someInt = 3
var anotherInt = 107
swapTwoValues(&someInt, &anotherInt)
// someInt is now 107, and anotherInt is now 3

var someString = "hello"
var anotherString = "world"
swapTwoValues(&someString, &anotherString)
// someString is now "world", and anotherString is now "hello"

struct IntStack {
  var items = [Int]()
  mutating func push(item:Int){
    items.append(item)
  }
  
  mutating func pop() -> Int {
    return items.removeLast()
  }
}

struct Stack<Element> {
  var items = [Element]()
  
  mutating func push(item: Element){
    items.append(item)
  }
  
  mutating func pop() -> Element {
    return items.removeLast()
  }
  
  var description:String {
    return items.description
  }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")
// the stack now contains 4 strings
print(stackOfStrings.description)

extension Stack {
  var topItem: Element? {
    return items.isEmpty ? nil : items[items.count - 1]
  }
}

if let topItem = stackOfStrings.topItem {
  print("The top item on the stack is \(topItem).")
}

func findStringIndex(array: [String], _ valueToFind: String) -> Int? {
  for (index, value) in array.enumerate() {
    if value == valueToFind {
      return index
    }
  }
  return nil
}

let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findStringIndex(strings, "llama") {
  print("The index of llama is \(foundIndex)")
}
// prints "The index of llama is 2"

/**

func findIndex<T>(array: [T], _ valueToFind: T) -> Int? {
for (index, value) in array.enumerate() {
if value == valueToFind {
return index
}
}
return nil
}

**/

func findIndex<T: Equatable>(array: [T], _ valueToFind: T) -> Int? {
  for (index, value) in array.enumerate() {
    if value == valueToFind {
      return index
    }
  }
  return nil
}

let doubleIndex = findIndex([3.14159, 0.1, 0.25], 9.3)
// doubleIndex is an optional Int with no value, because 9.3 is not in the array
let stringIndex = findIndex(["Mike", "Malcolm", "Andrea"], "Andrea")
// stringIndex is an optional Int containing a value of 2

protocol Container {
  typealias ItemType
  mutating func append(item: ItemType)
  var count: Int { get }
  subscript(i: Int) -> ItemType { get }
}

struct IntStack2: Container {
  // original IntStack implementation
  var items = [Int]()
  mutating func push(item: Int) {
    items.append(item)
  }
  mutating func pop() -> Int {
    return items.removeLast()
  }
  // conformance to the Container protocol
//  typealias ItemType = Int
  mutating func append(item: Int) {
    self.push(item)
  }
  var count: Int {
    return items.count
  }
  subscript(i: Int) -> Int {
    return items[i]
  }
}

struct Stack2<Element>: Container {
  // original Stack<Element> implementation
  var items = [Element]()
  mutating func push(item: Element) {
    items.append(item)
  }
  mutating func pop() -> Element {
    return items.removeLast()
  }
  // conformance to the Container protocol
  mutating func append(item: Element) {
    self.push(item)
  }
  var count: Int {
    return items.count
  }
  subscript(i: Int) -> Element {
    return items[i]
  }
}

extension Array: Container {}

func allItemsMatch<
  C1: Container, C2: Container
  where C1.ItemType == C2.ItemType, C1.ItemType: Equatable>
  (someContainer: C1, _ anotherContainer: C2) -> Bool {
    
    // check that both containers contain the same number of items
    if someContainer.count != anotherContainer.count {
      return false
    }
    
    // check each pair of items to see if they are equivalent
    for i in 0..<someContainer.count {
      if someContainer[i] != anotherContainer[i] {
        return false
      }
    }
    
    // all items match, so return true
    return true
    
}

var stackOfStrings2 = Stack2<String>()
stackOfStrings2.push("uno")
stackOfStrings2.push("dos")
stackOfStrings2.push("tres")

var arrayOfStrings2 = ["uno", "dos", "tres"]

if allItemsMatch(stackOfStrings2, arrayOfStrings2) {
  print("All items match.")
} else {
  print("Not all items match.")
}
// prints "All items match."













































