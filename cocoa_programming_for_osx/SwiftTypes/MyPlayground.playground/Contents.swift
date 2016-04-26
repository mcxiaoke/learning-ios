//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"
str = "Hello, Swift!"
let constStr = str
// constStr = "Hello, World!"
constStr.dynamicType

var nextYear:Int
var bodyTemp:Float
var hasPet:Bool

var ints:Array<Int>
var ints2:[Int]
var dict1:Dictionary<String,String>
var dict2:[String:String]
var set1:Set<Int>

let number = 42
let fmStation = 91.1
number.dynamicType
fmStation.dynamicType

var countingUp = ["One", "Two"]
let nameByParkingSpace = [13:"Alice", 27:"Bob"]
countingUp.dynamicType
nameByParkingSpace.dynamicType
let secondElement = countingUp[1]

let emptyString = String()
let emptyArrayOfInts = [Int]()
let emptySetOfFloast = Set<Float>()
let defaultNumber = Int()
let defaultBool = Bool()

let meaningOfLife = String(number)
let availableRooms = Set([205,411,412])
let defaultFloat = Float()
let floatFromLiteral = Float(3.14)


let easyPi = 3.14
let floatFromDouble = Float(easyPi)
let floatingPi:Float = 3.14
easyPi.dynamicType
floatingPi.dynamicType

let eString = ""
eString.isEmpty
countingUp.count

countingUp.append("three")
let countingDown = countingUp.reverse()

var oFloat:Float?
var oArray:[String]?
var oStrings:[String?]?

oFloat = 3.14
oArray = ["One", "Two", "Three"]
oStrings = [nil,"Hello","World"]
oStrings?[1]?.isEmpty

if let os = oStrings?[1] {
  os
}
if let oo = oStrings?[0]{
  oo
}else{
  "oStrings[0] is nil"
}

let sd = [13:"Alice", 26:"John", 18:"Smith"]
let sa:String? = sd[14]

if  let sb = sd[13]{
  print(sb)
}else{
  print("key not exists")
}

for i in 0 ..< countingUp.count {
  print(i)
}
for c in countingUp{
  print(c)
}

for (k,v) in sd{
  print("\(k) = \(v)")
}

enum PieType{
  case Apple
  case Cherry
  case Pecan
}

let fp = PieType.Apple
fp.dynamicType

var pies:[PieType] = []
pies.append(.Apple)

let name:String
switch fp {
case .Apple:
  name = "Apple"
case .Cherry:
  name = "Cherry"
case .Pecan:
  name = "Pecan"
}
name

enum PieType2:Int{
  case Apple
  case Cherry
  case Pecan
}

let pr = PieType2.Pecan.rawValue
if let pt = PieType2(rawValue:pr){
  // Got a valid PieType2
}








































