//: Playground - noun: a place where people can play
// https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/OptionalChaining.html#//apple_ref/doc/uid/TP40014097-CH21-ID245

import UIKit


class Person {
  var residence: Residence?
}

class Room {
  let name: String
  init(name: String) { self.name = name }
}

class Address {
  var buildingName: String?
  var buildingNumber: String?
  var street: String?
  func buildingIdentifier() -> String? {
    if buildingName != nil {
      return buildingName
    } else if buildingNumber != nil && street != nil {
      return "\(buildingNumber) \(street)"
    } else {
      return nil
    }
  }
}

class Residence {
  var rooms = [Room]()
  var numberOfRooms: Int {
    return rooms.count
  }
  subscript(i: Int) -> Room {
    get {
      return rooms[i]
    }
    set {
      rooms[i] = newValue
    }
  }
  func printNumberOfRooms() {
    print("The number of rooms is \(numberOfRooms)")
  }
  var address: Address?
}

let john = Person()
// let roomCount = john.residence!.numberOfRooms // runtime error
let roomCount = john.residence?.numberOfRooms
roomCount.dynamicType

if let roomCount = john.residence?.numberOfRooms {
  print("John's residence has \(roomCount) room(s).")
} else {
  print("Unable to retrieve the number of rooms.")
}

john.residence = Residence()

if let roomCount = john.residence?.numberOfRooms {
  print("John's residence has \(roomCount) room(s).")
} else {
  print("Unable to retrieve the number of rooms.")
}

john.residence = nil
let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
john.residence?.address = someAddress // fail

func createAddress() -> Address {
  print("Function was called.")
  
  let someAddress = Address()
  someAddress.buildingNumber = "29"
  someAddress.street = "Acacia Road"
  
  return someAddress
}
john.residence?.address = createAddress() // func not called

if john.residence?.printNumberOfRooms() != nil { // Void
  print("It was possible to print the number of rooms.")
} else {
  print("It was not possible to print the number of rooms.")
}
// prints "It was not possible to print the number of rooms."

if let firstRoomName = john.residence?[0].name {
  print("The first room name is \(firstRoomName).")
} else {
  print("Unable to retrieve the first room name.")
}
// prints "Unable to retrieve the first room name."

john.residence?[0] = Room(name: "Bathroom") // fail

let johnsHouse = Residence()
johnsHouse.rooms.append(Room(name: "Living Room"))
johnsHouse.rooms.append(Room(name: "Kitchen"))
john.residence = johnsHouse

if let firstRoomName = john.residence?[0].name {
  print("The first room name is \(firstRoomName).")
} else {
  print("Unable to retrieve the first room name.")
}
// prints "The first room name is Living Room."

var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0]++
testScores["Brian"]?[0] = 72 // fail
testScores
// the "Dave" array is now [91, 82, 84] and the "Bev" array is now [80, 94, 81]

if let johnsStreet = john.residence?.address?.street {
  print("John's street name is \(johnsStreet).")
} else {
  print("Unable to retrieve the address.")
}

let johnsAddress = Address()
johnsAddress.buildingName = "The Larches"
johnsAddress.street = "Laurel Street"
john.residence?.address = johnsAddress

john.residence?.address?.street.dynamicType

if let johnsStreet = john.residence?.address?.street {
  print("John's street name is \(johnsStreet).")
} else {
  print("Unable to retrieve the address.")
}

if let buildingIdentifier = john.residence?.address?.buildingIdentifier() {
  print("John's building identifier is \(buildingIdentifier).")
}

john.residence?.address?.buildingIdentifier().dynamicType

if let beginsWithThe =
  john.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginsWithThe {
      print("John's building identifier begins with \"The\".")
    } else {
      print("John's building identifier does not begin with \"The\".")
    }
}
// prints "John's building identifier begins with "The"."














