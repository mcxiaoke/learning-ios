//: Playground - noun: a place where people can play
// https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html#//apple_ref/doc/uid/TP40014097-CH5-ID309
// http://wiki.jikexueyuan.com/project/swift/chapter2/01_The_Basics.html

import UIKit


let maximumNumberOfLoginAttempts = 10
let currentLoginAttempt = 0

var welcomeMessage:String
welcomeMessage = "Hello"

var red, green, blue : Double

let π = 3.14159
let 你好 = "你好世界"
let 🐶🐮 = "dogcow"

var friendlyWelcome = "Hello!"
friendlyWelcome = "Bonjour!"

let languageName = "Swift"
// languageName = "Swift++" // error

print(friendlyWelcome)
print(languageName,terminator:"")
print("The current value is \(friendlyWelcome)")

/* 这是第一个多行注释的开头
/* 这是第二个被嵌套的多行注释 */
这是第一个多行注释的结尾 */

let cat = "🐱"; print(cat)

let minValue = UInt8.min
let maxValue = UInt8.max

let meaningOfLife = 42 // Int
let pi = 3.1415926 // Double
let anotherPi = 3 + 0.1415926 // Double

let decimalInt = 17
let binaryInt = 0b10001
let octalInt = 0o21
let hexadecimalInt = 0x11

let decimalDouble = 12.1875
let exponentDouble = 1.21875e1
let hexadecimalDouble = 0xC.3p0

let paddedDouble = 000123.456
let oneMillion = 1_000_000
let justOverOneMillion = 1_000_000.000_000_1

let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
let twoThousandAndOne = twoThousand + UInt16(one)

let three = 3
let pointOneFourFiveNine = 0.14159
let thePi = Double(three) + pointOneFourFiveNine

let integerPi = Int(thePi)


typealias AudioSample = UInt16
var maxAmplitudeFound = AudioSample.min

let orangesAreOrange = true
let turnipsAreDelicious = false

if turnipsAreDelicious {
  print("Mmm, tasty turnips!")
}else{
  print("Eww, turnips are horrible.")
}

let i = 1
if i == 1 {
  //if i { // error
  // some code
}

let http404error = (404, "Not Found")
http404error.0
http404error.1

let (statusCode, statusMessage) = http404error
print("status code is \(statusCode)")
print("status message \(statusMessage)")

let (justStatusCode,_) = http404error
print("The status code is \(justStatusCode)")

let http200Status = (statusCode: 200, description: "OK")
http200Status.statusCode
http200Status.0
http200Status.description
http200Status.1

let possibleNumber = "123"
let convertedNumber = Int(possibleNumber) // Int?
convertedNumber!

var serverResponseCode: Int? = 404
serverResponseCode = nil

var nonOptionInt: Int = 100
// nonOptionInt = nil // error

var surveyAnswer: String? // default is nil
print(surveyAnswer)

if convertedNumber != nil {
  print("convertedNumber contains some integer value.")
  print("convertedNumber has an integer value of \(convertedNumber!).")
}

var optionalName: String?

if let constantName = optionalName {
  print("optional name has string value")
}

if let actualNumber = Int(possibleNumber) {
  print("possible number has a integer")
}else{
  print("possible number cannot be converted to integer.")
}

if let firstNumber = Int("4"), secondNumber = Int("42") where firstNumber < secondNumber {
  print("\(firstNumber) < \(secondNumber)")
}

let possibleString:String? = "An optional string."
let forcedString:String=possibleString! // need !
let assumedString:String!="An implicitly unwrapped optional string."
let implicitString:String = assumedString // not need !

if assumedString != nil {
  print(assumedString)
}

func canThrowAnError() throws {
  // code
}

do {
  try canThrowAnError()
} catch {
 // handle error
}

let age = 23
assert(age > 0)
assert(age > 0, "A person's age cannot be less than zero")
































