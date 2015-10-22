//: Playground - noun: a place where people can play
// https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Inheritance.html#//apple_ref/doc/uid/TP40014097-CH17-ID193
// http://wiki.jikexueyuan.com/project/swift/chapter2/13_Inheritance.html
import UIKit

class Vehicle {
  var currentSpeed = 0.0
  var description:String {
    return "traveling at \(currentSpeed) miles per hour"
  }
  
  func makeNoise(){
    // do nothing
  }
}

let someVehicle = Vehicle()
print("Vehicle: \(someVehicle.description)")

class Bicycle: Vehicle {
   var hasBasket = false
  
}

let bicycle = Bicycle()
bicycle.hasBasket = true
bicycle.currentSpeed = 15.0
print("Bicycle: \(bicycle.description)")

class Tandem: Bicycle {
  var currentNumberOfPassengers = 0
}

let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
print("Tandem: \(tandem.description)")

class Train: Vehicle {
  override func makeNoise() {
    print("Choo Choo")
  }
}

let train = Train()
train.makeNoise()

class Car: Vehicle {
  var gear = 1
  override var description: String {
    return super.description + " in gear \(gear)"
  }
}

let car = Car()
car.currentSpeed = 30.0
car.gear = 3
print("Car: \(car.description)")

class AutomaticCar: Car {
  override var currentSpeed:Double {
    didSet {
      gear = Int(currentSpeed / 10.0) + 1
    }
  }
}

let automatic = AutomaticCar()
automatic.currentSpeed = 40.0
print("AutomaticCar: \(automatic.description)")



























