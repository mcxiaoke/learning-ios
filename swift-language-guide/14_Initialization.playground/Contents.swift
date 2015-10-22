//: Playground - noun: a place where people can play
// https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html#//apple_ref/doc/uid/TP40014097-CH18-ID203
// http://wiki.jikexueyuan.com/project/swift/chapter2/14_Initialization.html

import UIKit

struct Fahrenheit {
  // var temperature = 32.0
  var temperature:Double
  
  init(){
    temperature = 32.0
  }
}

var f = Fahrenheit()
f.temperature

struct Celsius {
  var temperatureInCellsius:Double
  
  init(fromFahrenheit fahrenheit:Double){
    temperatureInCellsius = (fahrenheit - 32.0)/1.8
  }
  
  init(fromKelvin kelvin:Double){
    temperatureInCellsius = kelvin - 273.15
  }
  
  init(_ celsius :Double){
    temperatureInCellsius = celsius
  }
}

let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
let freezingPointOfWater = Celsius(fromKelvin: 273.15)
let freezingPointOfWater2 = Celsius(0.0)

struct Color {
  var red, green, blue:Double
  init(red:Double, green:Double, blue:Double){
    self.red = red
    self.green = green
    self.blue = blue
  }
  
  init(white:Double){
    red = white
    green = white
    blue = white
  }
}

let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)
// let veryGreen = Color(0.0,1.0,0.0) // error

class SurveyQuestion {
  let text:String // cannot modify
  var response:String?
  
  init(text:String){
    self.text = text
  }
  
  func ask(){
    print(text)
  }
}

let cheeseQustion = SurveyQuestion(text: "Do you like cheese?")
cheeseQustion.ask()
cheeseQustion.response = "Yes, I do like cheese."

class ShoppingListItem {
  var name:String?
  var quantity = 1
  var purchased = false
  var notes:[Int]?
  
}

var item = ShoppingListItem()
item.name
item.quantity
item.purchased
item.notes

struct Size {
  var width = 0.0, height = 0.0
}

let twoByTwo = Size(width: 2.0, height: 2.0)
twoByTwo

struct Point {
  var x = 0.0, y = 0.0
}

struct Rect {
  var origin = Point()
  var size = Size()
  
  init() {}
  
  init(origin:Point, size:Size){
    self.origin = origin
    self.size = size
  }
  
  init(center:Point, size:Size){
    let originX = center.x - (size.width/2)
    let originY = center.y - (size.height/2)
    self.init(origin:Point(x:originX,y:originY),size:size)
  }
}

let basicRect = Rect()
let originRect = Rect(origin: Point(x:2.0,y:2.0), size: Size(width: 5.0, height: 5.0))
let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))
print("basiceRect:\(basicRect) originRect:\(originRect) centerRect:\(centerRect)")

class Vehicle {
  var numberOfWheels = 0
  var description: String {
    return "\(numberOfWheels) wheel(s)"
  }
}

let vehicle = Vehicle()
print("Vehicle: \(vehicle.description)")

class Bicycle: Vehicle {
   override init() {
    super.init()
    numberOfWheels = 2
  }
}

let bicycle = Bicycle()
print("Bicycle: \(bicycle.description)")

class Food {
  var name:String
  init(name:String){
      self.name = name
  }
  
  convenience init(){
    self.init(name:"[Unnamed]")
  }
}

let namedMeat = Food(name: "Bacon")
let mysteryMeat = Food()

class RecipeIngredient: Food {
  var quantity: Int
  init(name: String, quantity: Int) {
    self.quantity = quantity
    super.init(name: name)
  }
  override convenience init(name: String) {
    self.init(name: name, quantity: 1)
  }
}

let oneMysteryItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)

class TheShoppingListItem: RecipeIngredient {
  var purchased = false
  var description: String {
    var output = "\(quantity) x \(name)"
    output += purchased ? " ✔" : " ✘"
    return output
  }
}

var breakfastList = [
  TheShoppingListItem(),
  TheShoppingListItem(name: "Bacon"),
  TheShoppingListItem(name: "Eggs", quantity: 6),
]
breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
  print(item.description)
}

struct Animal {
  let species: String
  init?(species: String) {
    if species.isEmpty { return nil }
    self.species = species
  }
}

let someCreature = Animal(species: "Giraffe")
someCreature.dynamicType
if let giraffe = someCreature {
  print("An animal was initialized with a species of \(giraffe.species)")
}

let anonymousCreature = Animal(species: "")
if anonymousCreature == nil {
  print("The anonymous creature could not be initialized")
}

enum TemperatureUnit {
  case Kelvin, Celsius, Fahrenheit
  init?(symbol: Character) {
    switch symbol {
    case "K":
      self = .Kelvin
    case "C":
      self = .Celsius
    case "F":
      self = .Fahrenheit
    default:
      return nil
    }
  }
}

let fahrenheitUnit = TemperatureUnit(symbol: "F")
fahrenheitUnit.dynamicType
if fahrenheitUnit != nil {
  print("This is a defined temperature unit, so initialization succeeded.")
}

let unknownUnit = TemperatureUnit(symbol: "X")
unknownUnit.dynamicType
if unknownUnit == nil {
  print("This is not a defined temperature unit, so initialization failed.")
}

enum TemperatureUnit2: Character {
  case Kelvin = "K", Celsius = "C", Fahrenheit = "F"
}

let fahrenheitUnit2 = TemperatureUnit2(rawValue: "F")
fahrenheitUnit2.dynamicType
if fahrenheitUnit2 != nil {
  print("This is a defined temperature unit, so initialization succeeded.")
}
// prints "This is a defined temperature unit, so initialization succeeded."

let unknownUnit2 = TemperatureUnit2(rawValue: "X")
unknownUnit2.dynamicType
if unknownUnit2 == nil {
  print("This is not a defined temperature unit, so initialization failed.")
}

class Product {
  let name:String!
  
  init?(name:String){
    self.name = name
    if name.isEmpty { return nil }
  }
}

if let bowTie = Product(name: "bow tie") {
  // bowTie.name != nil, always
  print("The product's name is \(bowTie.name)")
}

class CartItem: Product {
  let quantity: Int!
  init?(name: String, quantity: Int) {
    self.quantity = quantity
    super.init(name: name)
    if quantity < 1 { return nil }
    
  }
}

if let twoSocks = CartItem(name: "sock", quantity: 2) {
  print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
}

if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
  print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
} else {
  print("Unable to initialize zero shirts")
}

if let oneUnnamed = CartItem(name: "", quantity: 1) {
  print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
} else {
  print("Unable to initialize one unnamed product")
}

class Document {
  var name: String?
  // this initializer creates a document with a nil name value
  init() {}
  // this initializer creates a document with a non-empty name value
  init?(name: String) {
    self.name = name
    if name.isEmpty { return nil }
  }
}

class AutomaticallyNamedDocument: Document {
  override init() {
    super.init()
    self.name = "[Untitled]"
  }
  override init(name: String) {
    super.init()
    if name.isEmpty {
      self.name = "[Untitled]"
    } else {
      self.name = name
    }
  }
}

class UntitledDocument: Document {
  override init() {
    super.init(name: "[Untitled]")! // ! unwrapped
  }
}

class SomeClass {
  required init() {
    // initializer implementation goes here
  }
}

class SomeSubclass: SomeClass {
  required init() {
    // subclass implementation of the required initializer goes here
  }
}

struct Checkerboard {
  let boardColors: [Bool] = {
    var temporaryBoard = [Bool]()
    var isBlack = false
    for i in 1...10 {
      for j in 1...10 {
        temporaryBoard.append(isBlack)
        isBlack = !isBlack
      }
      isBlack = !isBlack
    }
    return temporaryBoard
  }()
  func squareIsBlackAtRow(row: Int, column: Int) -> Bool {
    return boardColors[(row * 10) + column]
  }
}

let board = Checkerboard()
print(board.squareIsBlackAtRow(0, column: 1))
// prints "true"
print(board.squareIsBlackAtRow(9, column: 9))
// prints "false"













