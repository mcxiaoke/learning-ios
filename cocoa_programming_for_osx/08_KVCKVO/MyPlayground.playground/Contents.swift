//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

class Student:NSObject {
  var name = ""
  var gradeLevel = 0
}

let s = Student()
s.setValue("Kelly", forKey: "name")
s.setValue(3, forKey: "gradeLevel")

