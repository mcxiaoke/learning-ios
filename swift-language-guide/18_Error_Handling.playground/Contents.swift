//: Playground - noun: a place where people can play
// https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ErrorHandling.html#//apple_ref/doc/uid/TP40014097-CH42-ID508

import UIKit

enum VendingMachineError: ErrorType {
  case InvalidSelection
  case InsufficientFunds(coinsNeeded: Int)
  case OutOfStock
}

throw VendingMachineError.InsufficientFunds(coinsNeeded: 5)

func canThrowErrors() throws -> String {
  return ""
}

func cannotThrowErrors() -> String {
  return ""
}

struct Item {
  var price: Int
  var count: Int
}

class VendingMachine {
  var inventory = [
    "Candy Bar": Item(price: 12, count: 7),
    "Chips": Item(price: 10, count: 4),
    "Pretzels": Item(price: 7, count: 11)
  ]
  var coinsDeposited = 0
  func dispenseSnack(snack: String) {
    print("Dispensing \(snack)")
  }
  
  func vend(itemNamed name: String) throws {
    guard var item = inventory[name] else {
      throw VendingMachineError.InvalidSelection
    }
    
    guard item.count > 0 else {
      throw VendingMachineError.OutOfStock
    }
    
    guard item.price <= coinsDeposited else {
      throw VendingMachineError.InsufficientFunds(coinsNeeded: item.price - coinsDeposited)
    }
    
    coinsDeposited -= item.price
    --item.count
    inventory[name] = item
    dispenseSnack(name)
  }
}

let favoriteSnacks = [
  "Alice": "Chips",
  "Bob": "Licorice",
  "Eve": "Pretzels",
]
func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
  let snackName = favoriteSnacks[person] ?? "Candy Bar"
  try vendingMachine.vend(itemNamed: snackName)
}

var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
  try buyFavoriteSnack("Alice", vendingMachine: vendingMachine)
} catch VendingMachineError.InvalidSelection {
  print("Invalid Selection.")
} catch VendingMachineError.OutOfStock {
  print("Out of Stock.")
} catch VendingMachineError.InsufficientFunds(let coinsNeeded) {
  print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
}
// prints "Insufficient funds. Please insert an additional 2 coins."

func someThrowingFunction() throws -> Int {
  // ...
  return 100
}

let x = try? someThrowingFunction()

let y: Int?
do {
  y = try someThrowingFunction()
} catch {
  y = nil
}

struct Data {
  var someProperty = 0
}

func fetchDataFromDisk() throws ->Data{
  return Data(someProperty: 1)
}

func fetchDataFromServer() throws ->Data{
  return Data(someProperty: 2)
}

func fetchData() -> Data? {
  if let data = try? fetchDataFromDisk() { return data }
  if let data = try? fetchDataFromServer() { return data }
  return nil
}

// let photo = try! loadImage("./Resources/John Appleseed.jpg")

func exists(filename:String) -> Bool {

}

func processFile(filename: String) throws {
  if exists(filename) {
    let file = open(filename)
    defer {
      close(file)
    }
    while let line = try file.readline() {
      // Work with the file.
    }
    // close(file) is called here, at the end of the scope.
  }
}








































