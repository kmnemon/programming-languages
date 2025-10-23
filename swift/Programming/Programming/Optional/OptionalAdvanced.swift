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
}
