//: Playground - noun: a place where people can play
// https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html#//apple_ref/doc/uid/TP40014097-CH20-ID48
// http://wiki.jikexueyuan.com/project/swift/chapter2/16_Automatic_Reference_Counting.html

import UIKit

class ThePerson {
  let name: String
  init(name:String){
    self.name = name
    print("\(name) is being initialized")
  }
  
  deinit{
    print("\(name) is being deinitialized")
  }
}

var reference1: ThePerson?
var reference2: ThePerson?
var reference3: ThePerson?

reference1 = ThePerson(name: "John Appleseed")
reference2 = reference1
reference3 = reference1
reference1 = nil
reference2 = nil
reference3 = nil

class Person {
  let name:String
  init(name:String){
    self.name = name
  }
  var apartment:Apartment?
  deinit{
    print("\(name) is being deinitialized")
  }
}

class Apartment {
  let unit:String
  init(unit:String) {
    self.unit = unit
  }
  weak var tenant:Person? // weak ref
  deinit{
    print("Apartment \(unit) is being deinitialized")
  }
}

var john:Person?
var unit4A:Apartment?

john = Person(name: "John Appleseed")
unit4A = Apartment(unit: "4a")

john!.apartment = unit4A
unit4A!.tenant = john

john = nil
unit4A = nil

class Customer {
  let name: String
  var card: CreditCard?
  init(name: String) {
    self.name = name
  }
  deinit { print("\(name) is being deinitialized") }
}

class CreditCard {
  let number: UInt64
  unowned let customer: Customer
  init(number: UInt64, customer: Customer) {
    self.number = number
    self.customer = customer
  }
  deinit { print("Card #\(number) is being deinitialized") }
}

var john2: Customer?
john2 = Customer(name: "John Appleseed")
john2!.card = CreditCard(number: 1234_5678_9012_3456, customer: john2!)
john2 = nil

class Country {
  let name: String
  var capitalCity: City!
  init(name: String, capitalName: String) {
    self.name = name
    self.capitalCity = City(name: capitalName, country: self)
  }
}

class City {
  let name: String
  unowned let country: Country
  init(name: String, country: Country) {
    self.name = name
    self.country = country
  }
}

var country = Country(name: "Canada", capitalName: "Ottawa")
print("\(country.name)'s capital city is called \(country.capitalCity.name)")

class HTMLElement {
  
  let name: String
  let text: String?
  
  lazy var asHTML: Void -> String = {
    if let text = self.text {
      return "<\(self.name)>\(text)</\(self.name)>"
    } else {
      return "<\(self.name) />"
    }
  }
  
  init(name: String, text: String? = nil) {
    self.name = name
    self.text = text
  }
  
  deinit {
    print("\(name) is being deinitialized")
  }
  
}

let heading = HTMLElement(name: "h1")
let defaultText = "some default text"
heading.asHTML = {
  return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
}
print(heading.asHTML())
// prints "<h1>some default text</h1>"

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())
// prints "<p>hello, world</p>"
paragraph = nil

class SomeClass {
  var delegate:Person?
  
  init(){
    self.delegate = Person(name: "John")
  }
  lazy var someClosure: (Int, String) -> String = {
    [unowned self, weak delegate = self.delegate!] (index: Int, stringToProcess: String) -> String in
    // closure body goes here
    return ""
  }
  
  lazy var someClosure2: Void -> String = {
    [unowned self, weak delegate = self.delegate!] in
    // closure body goes here
    return ""
  }
}

class HTMLElement2 {
  
  let name: String
  let text: String?
  
  lazy var asHTML: Void -> String = {
    [unowned self] in
    if let text = self.text {
      return "<\(self.name)>\(text)</\(self.name)>"
    } else {
      return "<\(self.name) />"
    }
  }
  
  init(name: String, text: String? = nil) {
    self.name = name
    self.text = text
  }
  
  deinit {
    print("\(name) is being deinitialized")
  }
  
}

var paragraph2: HTMLElement2? = HTMLElement2(name: "p", text: "hello, world")
print(paragraph2!.asHTML())
paragraph2 = nil





























