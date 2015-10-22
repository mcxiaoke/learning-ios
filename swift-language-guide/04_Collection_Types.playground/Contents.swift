//: Playground - noun: a place where people can play
// https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/CollectionTypes.html#//apple_ref/doc/uid/TP40014097-CH8-ID105
// http://wiki.jikexueyuan.com/project/swift/chapter2/04_Collection_Types.html

import UIKit

var someInts = [Int]()
print("someInts is type \(someInts.dynamicType) with \(someInts.count) items")
someInts.append(3)
someInts=[]
someInts.dynamicType

var threeDoubles = [Double](count: 3, repeatedValue: 0.0)
var anotherThreeDoubles=[Double](count: 3, repeatedValue: 2.5)
var sixDoubles = threeDoubles + anotherThreeDoubles

var shoppingList:[String] = ["Eggs", "Milk"]
shoppingList.dynamicType
print("The shopping list contains \(shoppingList.count) items.")

shoppingList.isEmpty
shoppingList.append("Flour")
shoppingList += ["Baking Powder"]
shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
var firstItem = shoppingList[0]

shoppingList[0] = "Modified Eggs"
shoppingList[4...6] = ["Bananas", "Apples"]
shoppingList

shoppingList.insert("Maple Syrup", atIndex: 0)
let mapleSyrup = shoppingList.removeAtIndex(0)
let apples = shoppingList.removeLast()
let modifiedEggs = shoppingList.removeFirst()
shoppingList

for item in shoppingList {
  print(item)
}

for (index,value) in shoppingList.enumerate() {
  print("Item \(String(index+1)): \(value)")
}


var letters = Set<Character>()
letters.dynamicType
letters.insert("a")
letters = []
letters.dynamicType

var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
favoriteGenres.dynamicType
var favoriteGenres2: Set = ["Rock", "Classical", "Hip hop"]
favoriteGenres2.dynamicType

favoriteGenres.count
favoriteGenres.isEmpty

favoriteGenres.insert("Jazz")
let removedGenre = favoriteGenres.remove("Rock")
favoriteGenres.contains("Fork")

for genre in favoriteGenres {
  print("\(genre)")
}
for genre in favoriteGenres.sort() {
  print("\(genre)")
}

let oddDigits: Set = [1,3,5,7,9]
let evenDigits: Set = [0,2,4,6,8]
let singleDigitPrime: Set = [2,3,5,7]

oddDigits.union(evenDigits).sort()
oddDigits.intersect(singleDigitPrime).sort()
oddDigits.subtract(singleDigitPrime).sort()
oddDigits.exclusiveOr(singleDigitPrime).sort()

let houseAnimals: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]

houseAnimals.isSubsetOf(farmAnimals)
// true
farmAnimals.isSupersetOf(houseAnimals)
// true
farmAnimals.isDisjointWith(cityAnimals)
// true

var numberOfIntegers = [Int:String]()
numberOfIntegers.dynamicType

numberOfIntegers[16] = "sixteen"
numberOfIntegers = [:]
numberOfIntegers.dynamicType

// var airports: [String:String] = ["YYZ":"Toronto Person", "DUB":"Dublin"]
var airports = ["YYZ":"Toronto Person", "DUB":"Dublin"]
airports.dynamicType

airports.count
airports.isEmpty
airports.startIndex
airports.endIndex

airports["LHR"] = "London"
airports
airports["LHR"] = "London Heathrow"
airports

if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
  print("The old value for DUB was \(oldValue).")
}

if let airportName = airports["DUB"] {
  print("The name of the airport is \(airportName).")
} else {
  print("That airport is not in the airports dictionary.")
}

airports["APL"] = "Apple Internation"
airports["APL"] = nil

if let removedValue = airports.removeValueForKey("DUB") {
  print("The removed airport's name is \(removedValue).")
} else {
  print("The airports dictionary does not contain a value for DUB.")
}

for (key, value) in airports {
  print("\(key): \(value)")
}

for airportCode in airports.keys {
  print("Airport code: \(airportCode)")
}

for airportName in airports.values {
  print("Airport name: \(airportName)")
}

airports.keys.dynamicType
let airportCodes = [String](airports.keys)
airports.values.dynamicType
let airportNames = [String](airports.values)







































