//
//  OptionalAdvanced.swift
//  Programming
//
//  Created by ke on 10/23/25.
//

//1. Optional with map
func OptionalWithMap() {
    let characters: [Character] = ["a", "b", "c"]
    let firstCharacter = characters.first.map { String($0) } //Optional("a")
    
    let characters2: [Character] = ["a", "b", "c"]
    let firstCharacter2 = characters2.first.map { String($0) } //nil
}

func OptionalWithFlatMap() {
    let numbers = ["1", "2"]
    let i = numbers.first.map { Int($0) } //Optional(Optional(1)) i??
    let i2 = numbers.first.flatMap { Int($0) } //Optional(1) i?
    
    //another implement
    if let a = numbers.first, let b = Int(a) {
        print(b)
    }
    
}

//2. Force unwarp optional value with error message
infix operator !!

func !!<T>(wrapped: T?, failureText: @autoclosure () -> String) -> T {
    if let x = wrapped{ return x }
    fatalError(failureText())
}

//let s = "foo"
//let i = Int(s) !! "Expecting integer, got\"\(s)\""

//3. Asserting in debug builds
infix operator !?

//3.1 assert while debugging but return 0 in release
func !?<T: ExpressibleByIntegerLiteral>(wrapped: T?, failureText: @autoclosure () -> String) -> T {
    assert(wrapped != nil, failureText())
    return wrapped ?? 0
}

func !?<T: ExpressibleByArrayLiteral>(wrapped: T?, failureText: @autoclosure () -> String) -> T {
    assert(wrapped != nil, failureText())
    return wrapped ?? []
}

//3.2 assert while debugging but return provide value in release
func !?<T: ExpressibleByIntegerLiteral>(wrapped: T?, nilDefault: @autoclosure () -> (value: T, text: String)) -> T {
    assert(wrapped != nil, nilDefault().text)
    return wrapped ?? nilDefault().value
}

//4. detect optional chain hits a nil
func !?(wrapped: ()?, failureText: @autoclosure () -> String) {
    assert(wrapped != nil, failureText())
}

// var output: String? = nil
// output?.write("somes") !? "Wasn't exppecting chained nil here"
// output: "Wasn't exppecting chained nil here"
