//: Playground - noun: a place where people can play
// https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/StringsAndCharacters.html#//apple_ref/doc/uid/TP40014097-CH7-ID285
// http://wiki.jikexueyuan.com/project/swift/chapter2/03_Strings_and_Characters.html

import UIKit

let someString = "Some string literal value"

var emptyString = ""
var anotherEmptyString = String()
emptyString == anotherEmptyString
emptyString.isEmpty
anotherEmptyString.isEmpty

var variableString = "Horse"
variableString += " and carriage"
let constantString = "Highlander"
// constantString += " and another Highlander" // error

for character in "Dog!🐱猫咪".characters {
  print(character)
}

let exclamationMark: Character = "!"
let catCharacters: [Character] = ["C","a","t","!","🐱"]
let catString = String(catCharacters)
print(catString)

let string1 = "hello"
let string2 = " there"
var welcome = string1 + string2

var instruction = "look over"
instruction += string2

welcome.append(exclamationMark)

let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"

let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
// "Imageination is more important than knowledge" - Enistein
let dollarSign = "\u{24}"             // $, Unicode U+0024
let blackHeart = "\u{2665}"           // ♥, Unicode U+2665
let sparklingHeart = "\u{1F496}"      // 💖, Unicode U+1F496

let eAcute: Character = "\u{E9}"                         // é
let combinedEAcute: Character = "\u{65}\u{301}"
String(eAcute).characters.count
String(combinedEAcute).characters.count

let unusualMenagerie = "Koala 🐨, Snail 🐌, Penguin 🐧, Dromedary 🐪"
print("unusualMenagerie has \(unusualMenagerie.characters.count) characters")
unusualMenagerie.startIndex
unusualMenagerie.endIndex

let greeting = "Guten Tag!"
greeting[greeting.startIndex]
// greeting[greeting.endIndex] // error
greeting[greeting.endIndex.predecessor()]
// greeting.endIndex.successor() // error
greeting[greeting.startIndex.successor()]
let index = greeting.startIndex.advancedBy(7)
greeting[index]

for index in greeting.characters.indices {
  print("\(greeting[index]) ", terminator: " ")
}

var helloString = "hello"
helloString.insert("!", atIndex: helloString.endIndex)
helloString.insertContentsOf(" there".characters, at: helloString.endIndex.predecessor())
helloString.removeAtIndex(helloString.endIndex.predecessor())
print(helloString)

let range = helloString.endIndex.advancedBy(-6) ..< helloString.endIndex
helloString.removeRange(range)

let quotation = "We're a lot alike, you and I."
let sameQuotation = "We're a lot alike, you and I."
if quotation == sameQuotation {
  print("There two strings are considered equal")
}

let eAcuteQuestion = "Voulez-vous un caf\u{E9}?"
let combinedEAcuteQuestion = "Voulez-vous un caf\u{65}\u{301}?"
if eAcuteQuestion == combinedEAcuteQuestion {
  print("These two strings are considered equal")
}

let romeoAndJuliet = [
  "Act 1 Scene 1: Verona, A public place",
  "Act 1 Scene 2: Capulet's mansion",
  "Act 1 Scene 3: A room in Capulet's mansion",
  "Act 1 Scene 4: A street outside Capulet's mansion",
  "Act 1 Scene 5: The Great Hall in Capulet's mansion",
  "Act 2 Scene 1: Outside Capulet's mansion",
  "Act 2 Scene 2: Capulet's orchard",
  "Act 2 Scene 3: Outside Friar Lawrence's cell",
  "Act 2 Scene 4: A street in Verona",
  "Act 2 Scene 5: Capulet's mansion",
  "Act 2 Scene 6: Friar Lawrence's cell"
]

var act1SceneCount = 0
for scene in romeoAndJuliet {
  if scene.hasPrefix("Act 1 ") {
    ++act1SceneCount
  }
}
print("There are \(act1SceneCount) scenes in Act 1")

var mansionCount = 0
var cellCount = 0
for scene in romeoAndJuliet {
  if scene.hasSuffix("Capulet's mansion") {
    ++mansionCount
  }else if(scene.hasSuffix("Friar Lawrence's cell")) {
    ++cellCount
  }
}
print("mansion: \(mansionCount), cell:\(cellCount)")

let dogString = "Dog‼🐶"
for codeUnit in dogString.utf8 {
  print("\(codeUnit)",terminator: "")
}
for codeUnit in dogString.utf16 {
  print("\(codeUnit)",terminator: "")
}
for scalar in dogString.unicodeScalars {
  print("\(scalar.value) ", terminator: "")
}

































