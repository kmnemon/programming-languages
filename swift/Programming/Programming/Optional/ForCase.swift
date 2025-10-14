//
//  ForCase.swift
//  Programming
//
//  Created by ke Liu on 10/14/25.
//

func ForCase() {
    let stringNumbers = ["1", "2", "three"]
    let maybeInts = stringNumbers.map { Int($0) } //[Optional(1), Optional(2), nil]
    
    //1. print none nil value, i? = .some(i)
    for case let i? in maybeInts {
        print(i, terminator: " ")
    }
    
    
    //2. print nil
    for case nil in maybeInts {
        print("no value")
    }
}
