//: Playground - noun: a place where people can play
// https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Subscripts.html#//apple_ref/doc/uid/TP40014097-CH16-ID305
// http://wiki.jikexueyuan.com/project/swift/chapter2/12_Subscripts.html

import UIKit

class SubscriptSupport {
  var data:[Int] = [1,2,4,4,5,8]
  
  subscript(index: Int) -> Int {
    get {
      // getter
      return  data[index]
    }
    
    set(newValue) {
      // setter
      data[index] = newValue
    }
  }
}

var ss = SubscriptSupport()
ss[1]
ss[1] = 100

struct TimesTable {
  let multiplier: Int
  subscript(index:Int)->Int{
    return multiplier * index
  }
}

let threeTimesTable = TimesTable(multiplier: 3)
threeTimesTable[6]

var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
numberOfLegs["bird"] = 2

struct Matrix {
  let rows: Int, columns: Int
  var grid: [Double]
  init(rows: Int, columns: Int) {
    self.rows = rows
    self.columns = columns
    grid = Array(count: rows * columns, repeatedValue: 0.0)
  }
  func indexIsValidForRow(row: Int, column: Int) -> Bool {
    return row >= 0 && row < rows && column >= 0 && column < columns
  }
  subscript(row: Int, column: Int) -> Double {
    get {
      assert(indexIsValidForRow(row, column: column), "Index out of range")
      return grid[(row * columns) + column]
    }
    set {
      assert(indexIsValidForRow(row, column: column), "Index out of range")
      grid[(row * columns) + column] = newValue
    }
  }
}

var matrix = Matrix(rows: 2, columns: 2)
matrix[0, 1] = 1.5
matrix[1, 0] = 3.2

// let someValue = matrix[2, 2] // error, out of bounds


