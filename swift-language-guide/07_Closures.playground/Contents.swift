//: Playground - noun: a place where people can play
// https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Closures.html#//apple_ref/doc/uid/TP40014097-CH11-ID94
// http://wiki.jikexueyuan.com/project/swift/chapter2/07_Closures.html

import UIKit

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backwards(s1:String, s2:String) -> Bool {
  return s1 > s2
}

var reversed = names.sort(backwards)
reversed = names.sort({ (s1:String, s2:String) -> Bool in
  return s1 > s2
})
reversed = names.sort({ (s1:String, s2:String) -> Bool in return s1 > s2 })
reversed = names.sort( { s1, s2 in return s1 > s2 } ) // type inferring
reversed = names.sort({ s1, s2 in s1 > s2 })
reversed = names.sort( { $0 > $1 } )
reversed = names.sort(>)

func someFunctionThatTakesAClosure(closure: () -> Void) {
  // function body
  print("function!")
}

someFunctionThatTakesAClosure({
  // closure body
  print("closure!")
})

someFunctionThatTakesAClosure() {
  // closure body
  print("closure!")
}

someFunctionThatTakesAClosure {
  // closure body
  print("closure!")
}

reversed = names.sort() { $0 > $1 }

let digitNames = [
  0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
  5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]

let strings = numbers.map {
  (var number) -> String in
  var output = ""
  while number > 0 {
    output = digitNames[number % 10]! + output
    number /= 10
  }
  return output
}

print(strings)

func makeIncrementor(forIncrement amount: Int) -> () -> Int {
  var runningTotal = 0
  func incrementor() -> Int {
    runningTotal += amount
    return runningTotal
  }
  return incrementor
}

let incrementByTen = makeIncrementor(forIncrement: 10)
incrementByTen()
incrementByTen()
incrementByTen()

let alsoIncrementByTen = incrementByTen
alsoIncrementByTen()

makeIncrementor.dynamicType
incrementByTen.dynamicType

func someFunctionWithNoescapeClosure(@noescape closure: () -> Void) {
  closure()
}

var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: ()->Void) {
  completionHandlers.append(completionHandler)
}

class SomeClass {
  var x = 10
  func doSomething(){
    someFunctionWithEscapingClosure { self.x = 100 }
    someFunctionWithNoescapeClosure { x = 200 }
  }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)

completionHandlers.first?()
print(instance.x)

var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)

let customerProvider = {customersInLine.removeAtIndex(0)}
print(customersInLine.count)
customerProvider.dynamicType

print("Now serving \(customerProvider())!")
print(customersInLine.count)

func serveCustomer(customerProvider:() -> String) {
  print("Now serving \(customerProvider())!")
}
serveCustomer( { customersInLine.removeAtIndex(0) } )

func serveCustomer(@autoclosure customerProvider:()->String){
  print("Now serving \(customerProvider())!")
}
serveCustomer(customersInLine.removeAtIndex(0))

// customersInLine is ["Barry", "Daniella"]
var customerProviders: [() -> String] = []
func collectCustomerProviders(@autoclosure(escaping) customerProvider: () -> String) {
  customerProviders.append(customerProvider)
}
collectCustomerProviders(customersInLine.removeAtIndex(0))
collectCustomerProviders(customersInLine.removeAtIndex(0))

print("Collected \(customerProviders.count) closures.")
// prints "Collected 2 closures."
for customerProvider in customerProviders {
  print("Now serving \(customerProvider())!")
}
// prints "Now serving Barry!"
// prints "Now serving Daniella!"






































