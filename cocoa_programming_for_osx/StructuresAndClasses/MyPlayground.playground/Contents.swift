//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

struct Vector {
  var x:Double
  var y:Double
  
  init(){
//    x = 0
//    y = 0
    self.init(x:0, y:0)
  }
  
  init(x:Double, y:Double){
    self.x = x
    self.y = y
  }
  
  func add(vector:Vector) -> Vector {
    return Vector(x:x+vector.x, y: y+vector.y)
  }
  
  var length: Double {
    get {
      return sqrt(x*x + y*y)
    }
  }
  
  var length2: Double {
    return sqrt(x*x + y*y)
  }
  
}

func + (left:Vector, right:Vector) -> Vector {
  return left.add(right)
}

func * (left: Vector, right: Double) -> Vector {
  return Vector(x: left.x * right , y: left.y * right)
}

let gravity = Vector(x:0.0, y: -9.8)
gravity.x
gravity.y

let twoGs = gravity.add(gravity)
let twoGs2 = gravity + gravity
let twoGs3 = gravity * 2
twoGs2.y
twoGs3.y





























