//
//  ContentView.swift
//  SL
//
//  Created by Anand Upadhyay on 30/07/22.
//

import SwiftUI

//Enumeration
enum CompassPoint {
    case north
    case south
    case east
    case west
}

enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

protocol Resettable {
    init()
    mutating func reset()
}

extension Resettable {
    mutating func reset() {
        self = Self()
    }
}

struct Canvas: Resettable {
    var backgroundColor: Color?
    var foregroundColor: Color?
    var images = [Image]()
}


struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

struct Resolution {
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

struct ContentView: View {
    
    init(){
        playGround()
    }
    var findMaxFromArray: (([Int])-> Void)?
    var body: some View {

        Text("Hello, world!")
            .padding()
    }
    
    mutating func playGround(){

        print(1<1)
        
        /*
        //Implicitly unwrapped optional
        let possibleString: String? = "An optional string."
        let forcedString: String = possibleString! // requires an exclamation point
        print ("forcedString = \(forcedString)")
        let assumedString: String! = "An implicitly unwrapped optional string."
        let implicitString: String = assumedString // no need for an exclamation point
        print ("implicitString = \(implicitString)")
        
        //Unary Minus Operator
        let three = 3
        let minusThree = -three       // minusThree equals -3
        print (minusThree)
        let plusThree = -minusThree   // plusThree equals 3, or "minus minus three"
        print (plusThree)
        
        //Unary Plus Operator
        let minusSix = -6
        let alsoMinusSix = +minusSix  // alsoMinusSix equals -6
        print (alsoMinusSix)
        
        //Compound Assignment Operators
        var a = 1
        a += 2 // a is now equal to 3
        print("a=\(a)")
        //The compound assignment operators don’t return a value. For example, you can’t write
        let b = a += 2
        print("b=\(b)") //prints b=()
        
        
        let name = "world"
        if name == "World" {
            print("hello, world")
        } else {
            print("I'm sorry \(name), but I don't recognize you")
        }
        
        let aa = "Apple", bb = "Apple"
        if aa == bb{
            print("\(aa) == \(bb)")
        }
        
        if(1, "zebra") < (2, "apple")   // true because 1 is less than 2; "zebra" and "apple" aren't compared
        {
            print("\((1, "zebra")) < \((2, "apple"))")
        }
        if(3, "apple") < (3, "bird")    // true because 3 is equal to 3, and "apple" is less than "bird"
        {
            print("\((3, "apple")) < \((3, "bird"))")
        }
    
        if(4, "dog") == (4, "Dog")      // true because 4 is equal to 4, and "dog" is equal to "dog"
        {
            print("\((4, "dog")) == \((4, "Dog"))")
        }
        
        if("blue", -1) < ("purple", 1)        // OK, evaluates to true
        {
            print("\(("blue", -1)) < \(("purple", 1))")
        }
        
//        if("blue", false) < ("purple", true)  // Error because < can't compare Boolean values
//        {
//            print("\(("blue", false)) < \(("purple", true))")
//        }
        
        let contentHeight = 50
        let rowHeight = (contentHeight > 100 ? 100 : contentHeight)
        // rowHeight is equal to 90
        print("rowHeight = \(rowHeight)")
        
        let defaultColorName = "red"
        let userDefinedColorName: String?   // if this was var then it would have set defaults to nil
        userDefinedColorName = nil // initialization allowed only once as it is Optional Constant
        let colorNameToUse = userDefinedColorName ?? defaultColorName
        // userDefinedColorName is nil, so colorNameToUse is set to the default of "red"
        print("colorNameToUse = \(colorNameToUse)")
        //userDefinedColorName = "Greeen" //Immutable value 'userDefinedColorName' may only be initialized once compile error
        
        //range operator
        for index in 1...5 {
            print("\(index) times 5 is \(index * 5)")
        }
        var myList: [String]?
//        for index in 1..<myList!.count {
//            //Fatal error: Unexpectedly found nil while unwrapping an Optional value
//            print("\(index) times 5 is \(index * 5)")
//        }
        
        //Half-Open Range Operato
        for index in 0..<(myList ?? []).count {//(myList ?? [])
                print("\(index) times 5 is \(index * 5)")
        }
        
        
        //One-Sided Ranges
        myList = ["Anand", "Arun", "Archna", "Alok"]

        for name in myList![2...]{
            print(name)
        }
        
        print("")
        
        for name in myList![..<2] {
            print(name)
        }
        
        var range = ...5
        print("range contains 7 = \(range.contains(7))")
        print("range contains 3 = \(range.contains(3))")
        
        let quotation = """
        The White Rabbit put on his spectacles.  "Where shall I begin,
        please your Majesty?" he asked.

        "Begin at the beginning," the King said gravely, "and go on
        till you come to the end; then stop."
        """
        print("Quotation:\(quotation)")
        let multilineString = """
        These are the same.
        """
        print("multilineString:\(multilineString)")
        let softWrappedQuotation = """
        The White Rabbit put on his spectacles.  "Where shall I begin, \
        please your Majesty?" he asked.
        """
        print("softWrappedQuotation:\(softWrappedQuotation)")

        let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
        // "Imagination is more important than knowledge" - Einstein
        let dollarSign = "\u{24}"        // $,  Unicode scalar U+0024
        let blackHeart = "\u{2665}"      // ♥,  Unicode scalar U+2665
        let sparklingHeart = "\u{1F496}" // 💖, Unicode scalar U+1F496
        print("\n\(wiseWords)=\(dollarSign)=\(blackHeart)=\(sparklingHeart)")
        let threeDoubleQuotationMarks = """
        Escaping the two quotation mark \"\"
        Escaping all three quotation marks \"\"\"
        """
        print(" threeDoubleQuotationMarks = \(threeDoubleQuotationMarks)")
        let threeMoreDoubleQuotationMarks = #"""
        Here are three more double quotes: """
        """#
        print(" threeMoreDoubleQuotationMarks = \(threeMoreDoubleQuotationMarks)")
        var emptyString = ""               // empty string literal
        //var anotherEmptyString = String()  // initializer syntax
        // these two strings are both empty, and are equivalent to each other
        if emptyString.isEmpty {
            print("Nothing to see here")
        }
        
        for character in "Dog!🐶" {
            print(character)
        }
        
        
        var str1 = "hello"
        var str2 = " there"
        var welcome = str1 + str2
        str1 += str2
        print("String appending and joinong = \(str1) & \(welcome)")
        
        let multiplier = 3
        let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
        // message is "3 times 2.5 is 7.5"
        print(message)
        
        print(#" \(6*5) is \#(6*5)"#)

        //Turning an array of Characters into a String with no separator:
        let characterArray: [Character] = ["J", "o", "h", "n"]
        let string = String(characterArray)
        print(string) // prints "John"
        
        //Turning an array of Strings into a String with no separator:
        let stringArray1 = ["Bob", "Dan", "Bryan"]
        let string1 = stringArray1.joined(separator: "")
        print(string1) // prints: "BobDanBryan"
        
        //Turning an array of Strings into a String with a separator between words:
        let stringArray2 = ["Bob", "Dan", "Bryan"]
        let string2 = stringArray2.joined(separator: " ")
        print(string2) // prints: "Bob Dan Bryan"
        
        //Turning an array of Strings into a String with a separator between characters:
        let stringArray3 = ["car", "bike", "boat"]
        let characterArray1 = stringArray3.flatMap { $0 }
        let stringArray31 = characterArray1.map { String($0) }
        let string3 = stringArray31.joined(separator: ", ")
        print(string3) // prints: "c, a, r, b, i, k, e, b, o, a, t"
        
        //Turning an array of Floats into a String with a separator between numbers:
        let floatArray = [12, 14.6, 35]
        let stringArray4 = floatArray.map { String($0) }
        let string4 = stringArray4.joined(separator: "-")
        print(string4) // prints "12.0-14.6-35.0"

        let name1 = "King"
        let arr = name1.map { String($0) }
        let arr1 = Array(name1)

        print("String to Array:\(arr) \n or \(arr1) \n")
        
        let eAcute: Character = "\u{E9}"                         // é
        let combinedEAcute: Character = "\u{65}\u{301}"          // e followed by
        // eAcute is é, combinedEAcute is é
        
        let unusualMenagerie = "Koala 🐨, Snail 🐌, Penguin 🐧, Dromedary 🐪"
        print("unusualMenagerie has \(unusualMenagerie.count) characters")
        
        var word = "cafe"
        print("the number of characters in \(word) is \(word.count)")
        // Prints "the number of characters in cafe is 4"

        word += "\u{301}"    // COMBINING ACUTE ACCENT, U+0301

        print("the number of characters in \(word) is \(word.count)")
        // Prints "the number of characters in café is 4"
        
        let greeting = "Guten Tag!"
        print(greeting[greeting.startIndex])
        // G
        print(greeting[greeting.index(before: greeting.endIndex)])
        // !
        print(greeting[greeting.index(after: greeting.startIndex)])
        // u
        let index = greeting.index(greeting.startIndex, offsetBy: 7)
        print(greeting[index])
        // a
//        print(greeting[greeting.endIndex]) // Fatal error: String index is out of bounds
//        print(greeting.index(after: greeting.endIndex)) // Fatal error: String index is out of bounds

        for index in greeting.indices {
            print("\(greeting[index]) ", terminator: "")
        }
        
        //insert and remove
        welcome = "hello"
        welcome.insert("!", at: welcome.endIndex)
        // welcome now equals "hello!"
        print("Welcome = \(welcome)")
        welcome.insert(contentsOf: " there", at: welcome.index(before: welcome.endIndex))
        // welcome now equals "hello there!"
        print("Welcome = \(welcome)")
        welcome.remove(at: welcome.index(before: welcome.endIndex))
        // welcome now equals "hello there"
        print("Welcome = \(welcome)")
        let rangee = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex
        welcome.removeSubrange(rangee)
        // welcome now equals "hello"
        print("Welcome = \(welcome)")
        
        let greeting1 = "Hello, world!"
        let index1 = greeting1.firstIndex(of: ",") ?? greeting.endIndex
        let beginning = greeting1[..<index1]
        // beginning is "Hello"
        print(beginning)
        
        
        //comparision
        let street = "Straße"
        let alsoStreet = "STRASSE"

        print(street.lowercased())
        // straße
        print(alsoStreet.uppercased())
        // STRASSE

        print(street.lowercased() == alsoStreet.lowercased())
        // false

        print(street.uppercased() == alsoStreet.uppercased())
        // true

        print(street.compare(alsoStreet, options: .caseInsensitive) == .orderedSame)
        // true
        
        let aaa = "a"
        let capitalAA = "A"

        print("\(aaa.compare(capitalAA, options: .caseInsensitive))")
        // ComparisonResult.orderedSame

        if aaa.compare(capitalAA, options: .caseInsensitive) == .orderedSame {
            print( "a is equals to A" )
        }
        
        let scenes = "Food : This is the First Case : Food"
        if scenes.hasPrefix("Food :") {
            print(" Prefix \"Food :\"")
        }
        if scenes.hasSuffix(": Food") {
            print(" HasSuffix \": Food\"")
        }
        
        //Unicode and scallers
        //dogString.utf8
        //dogString.utf16
        //for scalar in dogString.unicodeScalars {
          //  print("\(scalar.value) ", terminator: "")
        //}
        
        var someInts: [Int] = []
        print("someInts is of type [Int] with \(someInts.count) items.")
        
        var threeDoubles = Array(repeating: 0.0, count: 3)
        // threeDoubles is of type [Double], and equals [0.0, 0.0, 0.0]
        print("array = \(threeDoubles)")
        var shoppingList: [String] = ["Eggs", "Milk"]
        var shoppingList1: [Any] = ["Eggs", 1,true,"Food"]
        print("shoppingList = \(shoppingList1)")
        
        shoppingList.append("Flour")
    
        shoppingList += ["Baking Powder"]
        // shoppingList now contains 4 items
        shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
        // shoppingList now contains 7 items
        print("shoppingList = \(shoppingList)")
        shoppingList[4...6] = ["Bananas", "Apples"]
        print("shoppingList = \(shoppingList)")
        shoppingList.insert("Maple Syrup", at: 0)
        shoppingList.remove(at: 0)
        print("shoppingList = \(shoppingList)")

        for (index, value) in shoppingList.enumerated() {
            print("Item \(index + 1): \(value)")
        }
        
        var letters = Set<Character>()
        print("letters is of type Set<Character> with \(letters.count) items.")
        letters.insert("a")
        print("Letter = \(letters)")
        letters = []
        print("Letter = \(letters)")
        var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
        print("favoriteGenres = \(favoriteGenres)")
        var favoriteGenres1: Set = ["Rock", "Classical", "Hip hop"]
        print("favoriteGenres = \(favoriteGenres1)")
        if favoriteGenres.isEmpty {
        }
        favoriteGenres.insert("Jazz")
        if let removedGenre = favoriteGenres.remove("Rock") {
        }
        if favoriteGenres.contains("Funk") {
            print("favoriteGenres contains Funk")
        }
        for genre in favoriteGenres.sorted() {
            print("\(genre)")
        }
        
        let oddDigits: Set = [1, 3, 5, 7, 9]
        let evenDigits: Set = [0, 2, 4, 6, 8]
        let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

        oddDigits.union(evenDigits).sorted()
        // [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        oddDigits.intersection(evenDigits).sorted()
        // []
        oddDigits.subtracting(singleDigitPrimeNumbers).sorted()
        // [1, 9]
        oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()
        // [1, 2, 9]
        let houseAnimals: Set = ["🐶", "🐱"]
        let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
        let cityAnimals: Set = ["🐦", "🐭"]

        houseAnimals.isSubset(of: farmAnimals)
        // true
        farmAnimals.isSuperset(of: houseAnimals)
        // true
        farmAnimals.isDisjoint(with: cityAnimals)
        // true
        
        var namesOfIntegers: [Int: String] = [:]
        
        namesOfIntegers[16] = "sixteen"
        print(namesOfIntegers)
        // namesOfIntegers now contains 1 key-value pair
        namesOfIntegers = [:]
        print(namesOfIntegers)
//        var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
        var airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
        print("The airports dictionary contains \(airports.count) items.")
        if airports.isEmpty {
            print("The airports dictionary is empty.")
        }
        airports["LHR"] = "London"
        print(airports)
        airports["LHR"] = "London Heathrow"
        print(airports)
        if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
            print("The old value for DUB was \(oldValue).")
        }
        if let removedValue = airports.removeValue(forKey: "DUB") {
            print("The removed airport's name is \(removedValue).")
        }
        for (airportCode, airportName) in airports {
            print("\(airportCode): \(airportName)")
        }
        for airportCode in airports.keys {
            print("Airport code: \(airportCode)")
        }
        // Airport code: LHR
        // Airport code: YYZ

        for airportName in airports.values {
            print("Airport name: \(airportName)")
        }

        //Control Flow
        let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
        for (animalName, legCount) in numberOfLegs {
            print("\(animalName)s have \(legCount) legs")
        }
        for index in 1...5 {
            print("\(index) times 5 is \(index * 5)")
        }
        
        let base = 3
        let power = 10
        var answer = 1
        for _ in 1...power {
            answer *= base
        }
        print("\(base) to the power of \(power) is \(answer)")
        
        let minuteInterval = 5
        let minutes = 60
        for tickMark in stride(from: 0, to: minutes, by: minuteInterval) {
            // render the tick mark every 5 minutes (0, 5, 10, 15 ... 45, 50, 55)
            print(tickMark, terminator: " ")
        }
        
        print()
        let hours = 12
        let hourInterval = 3
        for tickMark in stride(from: 3, through: hours, by: hourInterval) {
            // render the tick mark every 3 hours (3, 6, 9, 12)
            print(tickMark, terminator: " ")
        }
        
        print()
        //Snakes and Ladders
        let finalSquare = 25
        var board = [Int](repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
        var square = 0
        var diceRoll = 0
        print(board)
        while square < finalSquare {
            // roll the dice
            diceRoll += 1
            if diceRoll == 7 { diceRoll = 1 }
            // move by the rolled amount
            square += diceRoll
            if square < board.count {
                // if we're still on the board, move up or down for a snake or a ladder
                square += board[square]
            }
        }
        print("Game over!")
        
        let approximateCount = 62
        let countedThings = "moons orbiting Saturn"
        let naturalCount: String
        switch approximateCount {
        case 0:
            naturalCount = "no"
        case 1..<5:
            naturalCount = "a few"
        case 5..<12:
            naturalCount = "several"
        case 12..<100:
            naturalCount = "dozens of"
        case 100..<1000:
            naturalCount = "hundreds of"
        default:
            naturalCount = "many"
        }
        print("There are \(naturalCount) \(countedThings).")
        
        let anotherCharacter: Character = "a"
        switch anotherCharacter {
        case "a", "A":
            print("The letter A")
        default:
            print("Not the letter A")
        }
        
        let somePoint = (1, 1)
        switch somePoint {
        case (0, 0):
            print("\(somePoint) is at the origin")
        case (_, 0):
            print("\(somePoint) is on the x-axis")
        case (0, _):
            print("\(somePoint) is on the y-axis")
        case (-2...2, -2...2):
            print("\(somePoint) is inside the box")
        default:
            print("\(somePoint) is outside of the box")
        }
        
        let anotherPoint = (2, 0)
        switch anotherPoint {
        case (let x, 0):
            print("on the x-axis with an x value of \(x)")
        case (0, let y):
            print("on the y-axis with a y value of \(y)")
        case let (x, y):
            print("somewhere else at (\(x), \(y))")
        }
        
        let yetAnotherPoint = (1, -1)
        switch yetAnotherPoint {
        case let (x, y) where x == y:
            print("(\(x), \(y)) is on the line x == y")
        case let (x, y) where x == -y:
            print("(\(x), \(y)) is on the line x == -y")
        case let (x, y):
            print("(\(x), \(y)) is just some arbitrary point")
        }
        
        let someCharacter: Character = "r"
        switch someCharacter {
        case "a", "e", "i", "o", "u":
            print("\(someCharacter) is a vowel")
        case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
             "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
            print("\(someCharacter) is a consonant")
        default:
            print("\(someCharacter) isn't a vowel or a consonant")
        }
        
        let inputText1 = "adas23123asad"
        let set1 = CharacterSet.decimalDigits
        let sanitized1 = inputText1.removingCharacters(in: set1)
        print(sanitized1)
        
        let set = CharacterSet(charactersIn: "+*#0123456789")
        let stripped = inputText1.components(separatedBy: set.inverted).joined()
        print(stripped)
        
        print(greet(person: "Anna"))
        
        if let bounds = minMax(array: [8, -6, 2, 109, 3, 71]) {
            print("min is \(bounds.min) and max is \(bounds.max)")
        }

        
        print(greet1(person: "Bill", from: "Cupertino"))
        print(greet1(person: "Montesa"))
        
        print("arithmetic Mean: \(arithmeticMean(1, 2, 3, 4, 5))")
        // returns 3.0, which is the arithmetic mean of these five numbers
        print("arithmetic Mean: \(arithmeticMean(3, 8.25, 18.75))")
        
        //In-out parameters can’t have default values, and variadic parameters can’t be marked as inout.
        
        var someInt = 3
        var anotherInt = 107
        swapTwoInts(&someInt, &anotherInt)
        print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
        */
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        func backward(_ s1: String, _ s2: String) -> Bool {
            return s1 > s2
        }
        var reversedNames = names.sorted(by: backward)
        print("ReverseName:\(reversedNames)")
        //Closure Expression Syntax
        reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
            return s1 > s2
        })
        print("ReverseName:\(reversedNames)")
        //Inferring Type From Context
        reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 } )
        print("ReverseName:\(reversedNames)")
        //Implicit Returns from Single-Expression Closures
        reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )
        print("ReverseName:\(reversedNames)")
        //Shorthand Argument Names
        reversedNames = names.sorted(by: { $0 > $1 } )
        print("ReverseName:\(reversedNames)")
        //Operator Methods
        reversedNames = names.sorted(by: >)
        print("ReverseName:\(reversedNames)")
        
        
        let digitNames = [
            0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
            5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
        ]
        let numbers = [16, 58, 510]
        
        let stringss = numbers.map { (number) -> String in
            print(number)
            var number = number
            var output = ""
            repeat {
                output = digitNames[number % 10]! + output
//                print("=\(number)")
                number /= 10
                print("*\(number)")
                print("#\(output)")
            } while number > 0
            return output
        }
        print("stringss:\(stringss)")
        // strings is inferred to be of type [String]
        // its value is ["OneSix", "FiveEight", "FiveOneZero"]
        
        // customersInLine is ["Barry", "Daniella"]
        var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        print(customersInLine.count)

        var customerProviders: [() -> String] = []
        func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
            customerProviders.append(customerProvider)
        }
        collectCustomerProviders(customersInLine.remove(at: 0))
        collectCustomerProviders(customersInLine.remove(at: 0))

        print("Collected \(customerProviders.count) closures.")
        // Prints "Collected 2 closures."
        for customerProvider in customerProviders {
            print("Now serving \(customerProvider())!")
        }
        // Prints "Now serving Barry!"
        // Prints "Now serving Daniella!"
        
        print("Now serving \(customerProviders.first!())")
        print("Collected \(customerProviders.count) closures.")
        
        
        var directionToHead = CompassPoint.west
        directionToHead = .south
        switch directionToHead {
            case .north:
                print("Lots of planets have a north")
            case .south:
                print("Watch out for penguins")
            case .east:
                print("Where the sun rises")
            case .west:
                print("Where the skies are blue")
            }
        
            enum Beverage: CaseIterable {
                case coffee, tea, juice
            }
            let numberOfChoices = Beverage.allCases.count
            print("\(numberOfChoices) beverages available")
        
        var productBarcode = Barcode.upc(8, 85909, 51226, 3)
        switch productBarcode {
        case .upc(let numberSystem, let manufacturer, let product, let check):
            print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
        case .qrCode(let productCode):
            print("QR code: \(productCode).")
        }
        productBarcode = .qrCode("ABCDEFGHIJKLMNOP")
        switch productBarcode {
        case .upc(let numberSystem, let manufacturer, let product, let check):
            print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
        case .qrCode(let productCode):
            print("QR code: \(productCode).")
        }
        
        //Sub script
        var matrix = Matrix(rows: 2, columns: 2)
        matrix[1,1] = 2
        matrix[0, 1] = 1.5
        matrix[1, 0] = 3.2
        print("matrix 1,1:\(matrix[1,1])")
        print("matrix 0,1:\(matrix[0,1])")
        print("matrix 1,0:\(matrix[1,0])")
        
        //Type Subscripts
        let somePlanate = Planet[4]
        print("Planet 4:\(somePlanate)")
        
        //Raw Value
        let earthsOrder = Planet.earth.rawValue
        // earthsOrder is 3
        print("Row Value :\(earthsOrder)")

        let sunsetDirection = CompassPoint.west.rawValue
        // sunsetDirection is "west"
        print("Row Value :\(sunsetDirection)")
        
        //Initializing from a Raw Value
        let possiblePlanet = Planet(rawValue: 15)
//        print("possiblePlanet:\(possiblePlanet)")
        //Unexpectedly found nil while unwrapping an Optional value
        
        // possiblePlanet is of type Planet? and equals Planet.uranus
        if let somePlanet = Planet(rawValue: 11) {
            switch somePlanet {
            case .earth:
                print("Mostly harmless")
            default:
                print("Not a safe place for humans")
            }
        } else {
            print("There isn't a planet at position 11")
        }
        // Prints "There isn't a planet at position 11"
        
        //Recursive Enumerations
        let five = ArithmeticExpression.number(5)
        let four = ArithmeticExpression.number(4)
        let sum = ArithmeticExpression.addition(five, four)
        let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))
        print("sum:\(sum) \n product:\(product)")
        print(evaluate(product))
    
        //class
        let hd = Resolution(width: 1920, height: 1080)
        let tenEighty = VideoMode()
        tenEighty.resolution = hd
        tenEighty.interlaced = true
        tenEighty.name = "1080i"
        tenEighty.frameRate = 25.0
        print("tenEighty Frame Rate :\(tenEighty.frameRate)")

        let alsoTenEighty = tenEighty
        alsoTenEighty.frameRate = 30.0
        print("alsoTenEighty Frame Rate :\(alsoTenEighty.frameRate)")
        
        if tenEighty === alsoTenEighty {
            print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
        }

        let rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
        // the range represents integer values 0, 1, and 2
        //        rangeOfThreeItems.firstValue = 6
        //above line gives compile error : Cannot assign to property: 'rangeOfThreeItems' is a 'let' constant
        print("Range Of Three:\(rangeOfThreeItems.firstValue)")
        
        let manager = DataManager()
        manager.data.append("Some data")
        manager.data.append("Some more data")
        //lazy stored propery
        print(manager.importer.filename)

        //Computed Properties
        var square = Rect(origin: Point(x: 0.0, y: 0.0),
                          size: Size(width: 10.0, height: 10.0))
//        let initialSquareCenter = square.center
        // initialSquareCenter is at (5.0, 5.0)
        square.center = Point(x: 15.0, y: 15.0)
        print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
        
        let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
        print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
//        fourByFiveByTwo.volume = 12
        //above line gives compile error :Cannot assign to property: 'volume' is a get-only property
        
        //Propery observer
        let stepCounter = StepCounter()
        stepCounter.totalSteps = 200
        // About to set totalSteps to 200
        // Added 200 steps
        stepCounter.totalSteps = 360
        
        
        //Property Wrapper
        var rectangle = SmallRectangle()
        print(rectangle.height)
        // Prints "0"

        rectangle.height = 10
        print(rectangle.height)
        // Prints "10"

        rectangle.height = 24
        print(rectangle.height)
        
        //nil coalescing operator
//        let defaultColorName = "red"
//        let userDefinedColorName: String = "Black"
//        let  colorNameToUse = userDefinedColorName ?? defaultColorName // // Left side of nil coalescing operator '??' has non-optional type 'String', so the right side is never used


//        let userDefinedColorName: String?   // defaults to nil
//        let  colorNameToUse = userDefinedColorName ?? defaultColorName / /Constant 'userDefinedColorName' used before being initialized
//        print(colorNameToUse)
        
         //= = = = = = = = = = =//
        let range = ...5
        print(range.contains(7))   // false
        print(range.contains(4))   // true
        print(range.contains(-1))
//        print(range)
        
        var threeDoubleQuotationMarks = """
        Escaping the first quotation mark ""
        Escaping all three quotation marks ""\"
        """
        print (threeDoubleQuotationMarks + "\n====\n")
        
        threeDoubleQuotationMarks = #"""
        Here are three more double quotes: """
        """#
        print (threeDoubleQuotationMarks)

        print("\n====\n")

        doSomething()
    
        print(findMaxFromArray as Any)
        
        //iterating through tuple
        let tuple = (1, 2, "3")
        let tupleMirror = Mirror(reflecting: tuple)
        let tupleElements = tupleMirror.children.map({ $0.value })
        print("Tuple:\(tupleElements)")
        
//        storeQuery(query:"select * from users") // Extraneous argument label 'query:' in call
        storeQuery("select * from users")//This will work fine
        
        
        //Higher orer functions
        let numberArray = [1,2,3,4,5,2,3,5,3,1,3,2,1,5,6]
        let totalA = numberArray.reduce(0) { $0 + $1 }
        print("Total of Numbers:\(totalA)")
        
        let bookDictionary: [String:Int] = ["One":1,"Two":2,"Four":20,"Three":3]
        let totalB = bookDictionary.reduce(0) { (result, tupleOfKeyValue) in
            return result + tupleOfKeyValue.value
            //If dictionary contains duplicate keys
            //2022-11-29 13:53:11.721593+0530 SL[11101:706810] Swift/Dictionary.swift:826: Fatal error: Dictionary literal contains duplicate keys
        }
        
        //Maximum of a property value 
        let max = bookDictionary.values.max()
//        let highest = bookDictionary.filter { Dictionary<String, Int>.Element in
//
//        }
        print("Total value of Books :\(totalB) and max:\(String(describing: max))")
        
        //histogram
        let mappedItems = numberArray.map { ($0, 1) }
        let counts = Dictionary(mappedItems, uniquingKeysWith: +)
        print("Count :\(counts)")
        
        print("\n====\n")
    }
        
    //alias for parameters if used then no need to supply argument name while callign function
    func storeQuery(_ query: String) {
            print("query:\(query) \n")
    }
    
    mutating func findMaxNumber(array:[Int], handler: @escaping ([Int])->Void) {
       //step 2
         handler(array)
       //setp 3
        print("Somehting")
        findMaxFromArray = handler
    }
    
    mutating func findMaxNumber1(array:[Int], handler: ([Int])->Void){
       //step 2
         handler(array)
       //setp 3
        print("Somehting")
//        findMaxFromArray = handler
    }
    
    mutating func doSomething() {
       //setp 1
        findMaxNumber(array: [11,52,33,34,5,65,7,8,29,10]) {(result) in
          let maxNumber = result.max()!
          //step 4
           print("Max number from Array: \(maxNumber)")
        }
    }
    
    
    @propertyWrapper
    struct TwelveOrLess {
        private var number = 0
        var wrappedValue: Int {
            get { return number }
            set { number = min(newValue, 12) }
        }
    }

    struct SmallRectangle {
        @TwelveOrLess var height: Int
        @TwelveOrLess var width: Int
    }
    
    class StepCounter {
        var totalSteps: Int = 0 {
            willSet(newTotalSteps) {
                print("About to set totalSteps to \(newTotalSteps)")
            }
            didSet {
                if totalSteps > oldValue  {
                    print("Added \(totalSteps - oldValue) steps")
                }
            }
        }
    }
   
    
    enum Env: String {
        case debug
        case testFlight
        case appStore
    }

    struct App {
        struct Folders {
            static let documents: NSString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
            static let temporary: NSString = NSTemporaryDirectory() as NSString
        }
        static let version: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        static let build: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String

        // This is private because the use of 'appConfiguration' is preferred.
        private static let isTestFlight = Bundle.main.appStoreReceiptURL?.lastPathComponent == "sandboxReceipt"

        // This can be used to add debug statements.
        static var isDebug: Bool {
            #if DEBUG
            return true
            #else
            return false
            #endif
        }

        static var env: Env {
            if isDebug {
                return .debug
            } else if isTestFlight {
                return .testFlight
            } else {
                return .appStore
            }
        }
    }
    
    struct Point {
        var x = 0.0, y = 0.0
    }
    struct Size {
        var width = 0.0, height = 0.0
    }
    struct Rect {
        var origin = Point()
        var size = Size()
        var center: Point {
            get {
//                let centerX = origin.x + (size.width / 2)
//                let centerY = origin.y + (size.height / 2)
//                return Point(x: centerX, y: centerY)
                Point(x: origin.x + (size.width / 2),
                                  y: origin.y + (size.height / 2))
            }
            set{
                origin.x = newValue.x - (size.width / 2)
                origin.y = newValue.y - (size.height / 2)
            }
        }
    }
    struct Cuboid {
        var width = 0.0, height = 0.0, depth = 0.0
        var volume: Double {
            return width * height * depth
        }
    }
    class DataImporter {
        /*
        DataImporter is a class to import data from an external file.
        The class is assumed to take a nontrivial amount of time to initialize.
        */
        var filename = "data.txt"
        // the DataImporter class would provide data importing functionality here
    }

    class DataManager {
        //lazy stored propery
        lazy var importer = DataImporter()
        var data: [String] = []
        // the DataManager class would provide data management functionality here
    }

    
    struct FixedLengthRange {
        var firstValue: Int
        let length: Int
    }
    
    func evaluate(_ expression: ArithmeticExpression) -> Int {
        switch expression {
        case let .number(value):
            return value
        case let .addition(left, right):
            return evaluate(left) + evaluate(right)
        case let .multiplication(left, right):
            return evaluate(left) * evaluate(right)
        }
    }
    
    indirect enum ArithmeticExpression {
        case number(Int)
        case addition(ArithmeticExpression, ArithmeticExpression)
        case multiplication(ArithmeticExpression, ArithmeticExpression)
    }
    
    //Implicitly Assigned Raw Values
    enum CompassPoint: String {
        case north, south, east, west
    }
    func swapTwoInts(_ a: inout Int, _ b: inout Int) {
        a = a + b
        b = a - b
        a = a - b
        
//        let temporaryA = a
//        a = b
//        b = temporaryA
    }
    
    
    func greet1(person: String, from hometown: String = "Orlano") -> String {
        return "Hello \(person)!  Glad you could visit from \(hometown)."
    }
    
    func minMax(array: [Int]) -> (min: Int, max: Int)? {
        if array.isEmpty { return nil }
        var currentMin = array[0]
        var currentMax = array[0]
        for value in array[1..<array.count] {
            if value < currentMin {
                currentMin = value
            } else if value > currentMax {
                currentMax = value
            }
        }
        return (currentMin, currentMax)
    }
    
    func arithmeticMean(_ numbers: Double...) -> Double {
        var total: Double = 0
        for number in numbers {
            total += number
        }
        return total / Double(numbers.count)
    }
    
    func greet(person: String) -> String {
        "Hello, " + person + "!"
//        let greeting = "Hello, " + person + "!"
//        return greeting
    }
    
    

}

extension String {
  public func removingCharacters(in set: CharacterSet) -> String {
//    let filtered = unicodeScalars.filter { !set.contains($0) }
//    return String(String.UnicodeScalarView(filtered))
      return  self.components(separatedBy: set).joined()
  }
}

enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    static subscript(n: Int) -> Planet {
        return Planet(rawValue: n)!
    }
}


//extension Array {
//    func count() -> Int {
//        return (self != nil ?self:[]).count
//    }
//}
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
