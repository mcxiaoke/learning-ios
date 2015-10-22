//: Playground - noun: a place where people can play
// https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/GuidedTour.html
// http://wiki.jikexueyuan.com/project/swift/chapter1/02_a_swift_tour.html

import UIKit

var str = "Hello, playground"

print(str)

var myVar=12345
myVar=100

let myConst="Unix"

let myDouble: Double=20

let myFloat: Float=4

let myString=myConst+" -> "+String(myDouble)

let apples=10
let oranges=24

let appleSummay="I have \(apples) apples"

let orangeSummary="I have \(apples+oranges) pieces of fruit"

let helloSummay="Hello, \(myConst) os, a number is \(myFloat)"

var shoppingList=["catfish", "water","tupips","blue paint"]

shoppingList[1]="bottle  of water"

shoppingList

var occupations=[
  "Hello":"World",
  "Country":"China",
  "Good":"Rabbit",
]

occupations["Apple"]="iPhone 6p"

occupations

let scores=[75,43,103,87,12,40]
var teamScore=0

for score in scores{
  if score>50{
    teamScore+=3
  }else{
    teamScore+=1
  }

}

print(teamScore)

var optString:String? = "Hello, World"
print(optString == nil)

var optName:String? = "John Appleseed"
var greeting = "Hello!"

if let name = optName{
  greeting="Hello, \(name)"
}else{
  greeting="Hello, World"
}

let vegetable = "red pepper"
switch vegetable{
case "celery":
  print("Add some raisins and make ants on a log.")
case "cucumbr","watercress":
  print("That would make a good tea sandwich")
case let x where x.hasSuffix("pepper"):
  print("Is it a spicy \(x)?")
default:
  print("Everything tastes good in soup.")
}

let someNumbers=[
  "Prime":[2,3,5,7,11,13],
  "Fibonacci":[1,1,2,3,5,8,13,21],
  "Square":[1,4,9,16,25],
]

var largest=0
for (kind,numbers) in someNumbers{
  for num in numbers{
    if num > largest{
      largest=num
    }
  }
}

print(largest)

var n=2
while n<100{
  n=n*2
}
print(n)

var m=2
repeat {
  m=m*2
}while m<100

print(m)

var firstLoop=0
for i in 0..<4{
  firstLoop+=i
}
print(firstLoop)

var secondLoop=0
for i in 0...4{
  secondLoop+=i
}
print(secondLoop)

func greet(name:String, day:String, food:String) ->String{
  return "Hello \(name), today is \(day), I have eaten \(food)."
}

greet("Bob", day: "Tuesday", food:"Cakes")

func calculateStatistics(scores:[Int]) ->(min:Int, max:Int, sum:Int){
  var min=scores[0]
  var max=scores[0]
  var sum=0
  
  for score in scores{
    if score > max{
      max = score
    }else if score < min{
      min = score
    }
    sum+=score
  
  }
  return (min,max,sum)
}

let statistics=calculateStatistics([5,3,1034,80,29])
print(statistics.sum)
print(statistics.0)

func sumOf(numbers:Int...) -> Int{
  var sum=0
  for number in numbers{
    sum += number
  }
  return sum
}

sumOf()
sumOf(4,8,35,6)

//func average(numbers:Int...) -> Int{
//  var sum = sumOf(numbers)
//  return sum / numbers.count
//}
//
//average(2,43,5,46,10)


func returnFifteen() ->Int{
  var y=10
  func add(){
    y+=5
  }
  add()
  return y
}

returnFifteen()

func makeIncrementer()->(Int->Int){
  func addOne(number:Int)->Int{
    return number+1
  }
  return addOne
}

var inc=makeIncrementer()
inc(100)

func hasAnyMatches(list:[Int], condition:Int->Bool)->Bool{
  for item in list{
    if condition(item){
      return true
    }
  }
  return false
}

func lessThanTen(number:Int)->Bool{
  return number < 10
}

var numbers=[20,3,66,9,10,7,12]
var numbers2=[3213,14,575,800]

hasAnyMatches(numbers, condition: lessThanTen)
hasAnyMatches(numbers2, condition: lessThanTen)

let nm1=numbers.map { (number:Int) -> Int in
  return 3 * number
}
nm1

let nm2=numbers.map { (number:Int) -> Int in
  if number % 2==1 {
    return 0
  }
  else{
    return number
  }
}
nm2

let mappedNumbers=numbers.map({number in 3 * number})

mappedNumbers

let sortedNumbers = numbers.sort {$0 > $1}

sortedNumbers

class Shape{
  let shapeType="SimpleShape"
  var numberOfSides = 0
  var title=""
  var name:String
  
  init(name:String){
    self.name=name
  }
  
  func simpleDescription() ->String{
    return "A shape with \(numberOfSides) sides and title is \(title), name is \(name)"
  }
  
  func setTitle(title:String){
    self.title=title
  }

}

var shape=Shape(name:"Haha")
shape.numberOfSides=3
shape.setTitle("BigShape")
shape.simpleDescription()

class Square: Shape{
  var sideLength:Double
  
  init(sideLength:Double, name:String){
    self.sideLength=sideLength
    super.init(name: name)
    numberOfSides=4
  }
  
  func area()->Double{
    return sideLength * sideLength
  }
  
  override func simpleDescription() -> String {
    return "A square with sides of length \(sideLength)"
  }
  
}

let testSquare=Square(sideLength: 6.7, name: "Test Square")
testSquare.area()
testSquare.simpleDescription()

class Circle:Shape{
  var radius:Double
  
  init(radius:Double, name:String){
    self.radius=radius
    super.init(name: name)
  }
  
  func area()->Double{
    return 2 * 3.1415926 * self.radius * self.radius
  }
  
  override func simpleDescription() -> String {
    return "A circle with radius of \(radius)"
  }
  
}

let testCircle=Circle(radius: 5.0, name: "Test Circle")
testCircle.area()
testCircle.simpleDescription()

class EquilateralTriangle: Shape{
  var sideLength:Double=0.0
  
  init(sideLength:Double,name:String){
    self.sideLength=sideLength
    super.init(name: name)
    numberOfSides=3
  }
  
  var perimeter:Double{
    get {
      return 3.0 * sideLength
    }
    
    set {
      sideLength=newValue/3.0
    }
  }
  
  override func simpleDescription() -> String {
    return "An equilateral triagle with sides of length \(sideLength)"
  }
}

var triangle=EquilateralTriangle(sideLength: 3.6, name: "A Triangle")
triangle.perimeter
triangle.perimeter=75.0
triangle.sideLength


class TriangleAndSquare {
  var triangle: EquilateralTriangle {
    willSet {
      square.sideLength = newValue.sideLength
    }
  }
  var square: Square {
    willSet {
      triangle.sideLength = newValue.sideLength
    }
  }
  init(size: Double, name: String) {
    square = Square(sideLength: size, name: name)
    triangle = EquilateralTriangle(sideLength: size, name: name)
  }
}
var triangleAndSquare = TriangleAndSquare(size: 10, name: "another test shape")
print(triangleAndSquare.square.sideLength)
print(triangleAndSquare.triangle.sideLength)
triangleAndSquare.square = Square(sideLength: 50, name: "larger square")
print(triangleAndSquare.triangle.sideLength)

let optSquare:Square?=Square(sideLength: 2.5, name: "optional square")
let sideLength=optSquare?.sideLength

enum Rank:Int{
  case Ace=1
  case Two,Three,Four,Five,Six,Seven,Eight,Nine,Ten
  case Jack,Queen,King
  func simpleDescription()->String{
    switch self{
    case .Ace:
      return "ace"
    case .Jack:
      return "jack"
    case .Queen:
      return "queen"
    case .King:
      return "king"
    default:
      return String(self.rawValue)
    }
  }
}

let ace=Rank.Ace
let aceRawValue=ace.rawValue
let queen=Rank.Queen
let queenRawValue=queen.rawValue

func compareRank(rankA:Rank, rankB:Rank)->Bool{
  let rawA=rankA.rawValue
  let rawB=rankB.rawValue
  return rawA>rawB
}

let two=Rank.Two
let king=Rank.King
let rankCompareResult=compareRank(two, rankB: king)


enum Suit:Int{
  case Spades, Hearts, Diamonds, Clubs
  
  func simpleDescription()->String{
    switch self{
    case .Spades:
      return "spades"
    case .Hearts:
      return "hearts"
    case .Diamonds:
      return "diamonds"
    case .Clubs:
      return "clubs"
    }
  }
  
  func color()->String{
    switch self{
    case .Spades:
      return "black"
    case .Clubs:
      return "black"
    case .Hearts:
      return "red"
    case .Diamonds:
      return "red"
    }
  }
  
}

let hearts=Suit.Hearts
let heartsDescription=hearts.simpleDescription()
let heartColor=hearts.color()

struct Card {
  var rank:Rank
  var suit:Suit
  
  func simpleDescription()->String{
    return "Card(\(rank.simpleDescription()),\(suit.simpleDescription()))"
  }
  
}

let threeOfSpades=Card(rank: .Three, suit: .Spades)
let thressOfSpadesDescription=threeOfSpades.simpleDescription()

let lastSuit:Suit=Suit.Clubs
let lastRank=Rank.King

// http://stackoverflow.com/questions/24109691/add-a-method-to-card-that-creates-a-full-deck-of-cards-with-one-card-of-each-co
class Deck {
  var cards:[Card]
  
  init() {
    self.cards = Array<Card>()
    self.createDeck()
  }
  
  func createDeck() {
    let lastSuit:Suit=Suit.Clubs
    let lastRank=Rank.King
    for suit in 0...lastSuit.rawValue {
      for rank in 1...lastRank.rawValue {
        let newCard=Card(rank: Rank(rawValue: rank)!, suit: Suit(rawValue: suit)!)
        self.cards.append(newCard)
      }
    }
  }
  
  func simpleDescription()->String{
    var desc:String=""
    for card in self.cards{
      desc+=card.simpleDescription()
      desc+=" "
    }
    return desc
  }
}

let deck=Deck()
deck.simpleDescription()

enum ServerResponse{
  case Result(String, String)
  case Error(String)
  case Cancelled(String)
  
  func detail()->String{
    var response:String
    switch self{
    case let .Result(sunrise,sunset):
      response = "Sunrise is at\(sunrise) and sunset is at \(sunset)."
    case let .Error(error):
      response = "Failure... \(error)"
    case let .Cancelled(reason):
      response = "Cancelled... \(reason)"
    }
    return response
  }
}

let success = ServerResponse.Result("6:00 am", "8:09 pm")
let failure = ServerResponse.Error("Out of cheese.")
let cancelled=ServerResponse.Cancelled("No time to do this.")


switch success{
case let .Result(sunrise,sunset):
  let serverResponse = "Sunrise is at\(sunrise) and sunset is at \(sunset)."
case let .Error(error):
  let serverResponse = "Failure... \(error)"
case let .Cancelled(reason):
  let serverResponse = "Cancelled... \(reason)"
}

success.detail()
failure.detail()
cancelled.detail()

protocol ExampleProtocol{
  var simpleDescription:String { get }
  mutating func adjust()
}

class SimpleClass: ExampleProtocol {
  var simpleDescription:String = "A very simple class."
  var anotherProperty: Int = 69105
  func adjust() {
    simpleDescription += " Now 100% adjusted."
  }
}

var sc = SimpleClass()
sc.simpleDescription
sc.adjust()
sc.simpleDescription

struct SimpleStructure: ExampleProtocol {
  var simpleDescription:String = "A simple structure"
  mutating func adjust() {
    simpleDescription += " (adjusted)"
  }
}

var ss=SimpleStructure()
ss.simpleDescription
ss.adjust()
ss.simpleDescription

enum SimpleEnum: ExampleProtocol{
  case Base, Adjusted
  
  var simpleDescription: String {
      switch self{
      case .Base:
        return "A simple enum"
      case .Adjusted:
        return "A adjusted  enum."
      }
  }
  
  mutating func adjust() {
    self = SimpleEnum.Adjusted
  }
  
}

var se=SimpleEnum.Base
se.simpleDescription
se.adjust()
se.simpleDescription

extension Int: ExampleProtocol{
  var simpleDescription:String{
    return "The number \(self)"
  }
  
  mutating func adjust() {
    self += 42
  }

}

var num = 100
num.simpleDescription
num.adjust()
num.simpleDescription

extension Double{
  mutating func absValue(){
    if self < 0.0 {
      self = -self
    }
  }
}

var dou:Double = -123.45
dou
dou.absValue()

let protocolValue:ExampleProtocol = sc
protocolValue.simpleDescription
// protocolValue.anotherProperty


func repeatItem<Item>(item:Item, numberOfItems:Int)->[Item]{
  var result = [Item]()
  for _ in 0..<numberOfItems{
    result.append(item)
  }
  return result
}

repeatItem("Knock", numberOfItems: 4)


enum OptionalValue<Wrapped> {
  case None
  case Some(Wrapped)
}

var possibleInteger:OptionalValue<Int> = .None
possibleInteger = .Some(100)


func anyCommonElements <T: SequenceType, U: SequenceType where T.Generator.Element: Equatable, T.Generator.Element == U.Generator.Element> (lhs:T, _ rhs: U) -> Bool{
    for lhsItem in lhs{
      for rhsItem in rhs{
        if lhsItem == rhsItem {
          return true
        }
      }
    }
    return false
}

anyCommonElements([1,2,3,4], [2,3,5,6,9])































































