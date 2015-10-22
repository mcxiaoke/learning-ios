//: Playground - noun: a place where people can play
// https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Enumerations.html#//apple_ref/doc/uid/TP40014097-CH12-ID145
// http://wiki.jikexueyuan.com/project/swift/chapter2/08_Enumerations.html

import UIKit

enum SomeEnumation {
  // defination
}

enum CompassPoint {
  case North
  case South
  case East
  case West
}
CompassPoint.self

enum Planet { case Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune }
Planet.self

var directionToHead = CompassPoint.West
directionToHead = .East
directionToHead.dynamicType

directionToHead = .South

switch directionToHead {
case .North:
  print("Lots of planets have a north")
case .South:
  print("Watch out for penguins")
case .East:
  print("where the sun rises")
case .West:
  print("where the skies are blue")
}

let somePlanet = Planet.Mars
switch somePlanet {
case .Earth:
  print("Mostly harmless")
default:
  print("Not a safe place for humans")
}

enum Barcode {
  case UPCA(Int,Int,Int,Int)
  case QRCode(String)
}

var productBarcode = Barcode.UPCA(8, 85909, 51226, 3 )
productBarcode = .QRCode("ABCDEFGHIJKLMOP")

switch productBarcode {
case .UPCA(let numberSystem, let manufacturer, let product, let check):
  print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check).")
case .QRCode(let productCode):
  print("QR code: \(productCode).")
}

switch productBarcode {
case let .UPCA(numberSystem, manufacturer, product, check):
  print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check).")
case let .QRCode(productCode):
  print("QR code: \(productCode).")
}

enum ASCIIControlCharacter: Character {
  case Tab = "\t"
  case LineFeed = "\n"
  case CarriageReturn = "\r"
}
ASCIIControlCharacter.self
ASCIIControlCharacter.Tab.self
ASCIIControlCharacter.Tab.rawValue
ASCIIControlCharacter.Tab.dynamicType

enum ThePlanet: Int {
  case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}
ThePlanet.self
ThePlanet.Earth.self
ThePlanet.Earth.rawValue
ThePlanet.Earth.dynamicType

enum TheCompass: String {
  case North, South, East, West
}
TheCompass.self
TheCompass.South.self
TheCompass.South.rawValue
TheCompass.South.dynamicType

let possiblePlanet = ThePlanet(rawValue: 7)
possiblePlanet
if let possiblePlanet2 = ThePlanet(rawValue: 10) {
  switch possiblePlanet2 {
  case .Earth:
    print("Mostly harmless")
  default:
    print("Not a safe place for humans")
  }
}else{
  print("There isn't a planet at position 10")
}

enum ArithmeticExpression {
  case Number(Int)
  indirect case Addition(ArithmeticExpression, ArithmeticExpression)
  indirect case Multiplication(ArithmeticExpression, ArithmeticExpression)
}
ArithmeticExpression.self
ArithmeticExpression.Number.self
ArithmeticExpression.Number.dynamicType
ArithmeticExpression.Addition.self
ArithmeticExpression.Addition.dynamicType

indirect enum ArithmeticExpression2 {
  case Number(Int)
  case Addition(ArithmeticExpression2, ArithmeticExpression)
  case Multiplication(ArithmeticExpression2, ArithmeticExpression)
}

func evaluate(expression: ArithmeticExpression) -> Int {
  switch expression {
  case .Number(let value):
    return value
  case .Addition(let left, let right):
    return evaluate(left) + evaluate(right)
  case .Multiplication(let left, let right):
    return evaluate(left) * evaluate(right)
  }
}

let five = ArithmeticExpression.Number(5)
let four = ArithmeticExpression.Number(4)
let sum = ArithmeticExpression.Addition(five, four)
let product = ArithmeticExpression.Multiplication(sum, ArithmeticExpression.Number(2))
print(evaluate(product))







































