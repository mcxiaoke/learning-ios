//: Playground - noun: a place where people can play
// https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Functions.html#//apple_ref/doc/uid/TP40014097-CH10-ID158
// http://wiki.jikexueyuan.com/project/swift/chapter2/06_Functions.html

import UIKit

func sayHelloWorld() -> String {
  return "hello, world"
}
sayHelloWorld()

func sayHello(personName:String) -> String {
  return "Hello, " + personName + "!"
}
sayHello("Anna")
sayHello("Brain")

func halfOpenRangeLength(start:Int, end:Int) -> Int {
  return end - start
}
print(halfOpenRangeLength(1, end: 10))

func sayGoodbye(personName: String) {
  print("Goodbye, \(personName)!")
}
sayGoodbye("Dave")
sayGoodbye("John").dynamicType

func minMax(array:[Int]) ->(min:Int, max:Int)? {
  var cMin = array[0]
  var cMax = array[0]
  for value in array[1..<array.count] {
    if value < cMin {
      cMin = value
    }else if value > cMax {
      cMax = value
    }
  }
  return (cMin,cMax)
}

if let bounds = minMax([8,-6,2,109,3,71]) {
  print("min is \(bounds.min) and max is \(bounds.max)")
}

func sayHello(to person: String, and anotherPerson: String) -> String {
  return "Hello \(person) and \(anotherPerson)!"
}

print(sayHello(to: "Bill", and: "Ted"))

func someFunction(firstParameterName:Int, _ secondParameter: Int) {
  print("First: \(firstParameterName), Second: \(secondParameter)")
}
someFunction(1, 2)

func someFunction2(parameterWithDefault: Int = 12) {
  print("value is \(parameterWithDefault)")
}
someFunction2(6)
someFunction2()

func arithmeticMean(numbers: Double...) -> Double {
  var total:Double = 0
  for number in numbers {
    total += number
  }
  return total / Double(numbers.count)
}


arithmeticMean(1,2,3,4,5)
arithmeticMean(3.5,54,35)

func alignRight(var string:String, totalLength:Int, pad:Character) -> String {
  let amountToPad = totalLength - string.characters.count
  if amountToPad < 1 {
    return string
  }
//  let padString = String(pad)
  for _ in 1...amountToPad {
//    string = padString + string
    string.insert(pad, atIndex: string.startIndex)
  }
  return string
}
let originalString = "hello"
let paddedString = alignRight(originalString, totalLength: 10, pad: "-")

func swapTwoInts(inout a:Int, inout _ b: Int) {
  let tempA = a
  a = b
  b = tempA
}
swapTwoInts.dynamicType

var someInt = 3
var anotherInt = 108
swapTwoInts(&someInt, &anotherInt)
print("a=\(someInt), b=\(anotherInt)")
swap(&someInt, &anotherInt)
print("a=\(someInt), b=\(anotherInt)")

func addTwoInts(a: Int, _ b: Int) -> Int {
  return a + b
}

func multiplyTwoInts(a: Int, _ b: Int) -> Int {
  return a * b
}

func printHelloWorld(){
  print("hello, world")
}
printHelloWorld.dynamicType

var mathFunction: (Int, Int) -> Int = addTwoInts
mathFunction.dynamicType
mathFunction(4,5)

mathFunction = multiplyTwoInts
mathFunction.dynamicType
mathFunction(4,5)

let anotherMathFunction = addTwoInts
anotherMathFunction.dynamicType

func printMathResult(mathFunction: (Int, Int)->Int, _ a: Int, _ b: Int) {
  print("Result: \(mathFunction(a,b))")
}
printMathResult(addTwoInts, 4, 5)

func stepForward(input: Int) -> Int {
  return input + 1
}
func stepBackward(input: Int) -> Int {
  return input - 1
}

stepForward
stepBackward

func chooseStepFunction(backwards: Bool) -> (Int)->Int {
  return backwards ? stepBackward : stepForward
}

var currentValue = 3
let moveNearerToZero = chooseStepFunction(currentValue > 0)

while currentValue != 0 {
  print("\(currentValue)... ")
  currentValue = moveNearerToZero(currentValue)
}

print("current value = \(currentValue)")

func chooseStepFunction2(backwards: Bool) -> (Int) -> Int {
  func stepForward(input: Int) -> Int { return input + 1 }
  func stepBackward(input: Int) -> Int { return input - 1 }
  return backwards ? stepBackward : stepForward
}





























