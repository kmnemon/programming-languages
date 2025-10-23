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

