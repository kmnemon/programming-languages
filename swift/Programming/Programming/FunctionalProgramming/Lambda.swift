//
//  lambda.swift
//  swift
//
//  Created by ke on 4/8/24.
//

import Foundation

func filterFunction() {
    let numbers = [1, 2, 3, 4, 5]
    let evens = numbers.filter { $0.isMultiple(of: 2) } // 2, 4
}

func mapFunction() {
    let numbers2 = ["1", "2", "fish", "3"]
    let evensMap = numbers2.map(Int.init)
    
    let evensCompactMap = numbers2.compactMap(Int.init)
}

func lengthOfStrings(strings: [String]) -> [Int] {
    return strings.map { $0.count }
}

func containFunction() {
    let input = "i am a bad cat"
    if input.contains("am1") {
        print("found it")
    }
    
    
    let words = ["1989", "Fearless", "Red"]
    let input2 = "My favorite album is Fearless"
    print(words.contains(where: input2.contains))
}

func reduceFunction() {
    let numbers = [1, 3, 5, 7, 9]
    let result1 = numbers.reduce(0) { (int1, int2) -> Int in
        return int1 + int2
    }
    print(result1)
    
    let result2 = numbers.reduce(0, +)
    print(result2)
    
    let names = ["Taylor", "Paul", "Adele"]
    let longEnough = names.reduce(true) { $0 && $1.count > 4 }
    print(longEnough)
}

func forEachFunction() {
    ["a", "sdf", "sdfd"].forEach{print($0)}
}


func flatMapFunction() {
    let albums: [String?] = ["Fearless", nil, "Speak Now", nil, "Red"]
    let result = albums.compactMap { $0 }
    print(albums)
    print(result)
    
    
    let scores = ["100", "90", "Fish", "85"]
    let flatMapScores = scores.compactMap { Int($0) }
    print(flatMapScores)
}

struct Pet {
    var name: String
    var age: Int
}

struct User: Identifiable, Comparable {
    let id = UUID()
    var firstName: String
    var lastName: String

    static func <(lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}




func sortFunction() {
    let taylor = Pet(name: "Taylor", age: 26)
    let paul = Pet(name: "Paul", age: 36)
    let justin = Pet(name: "Justin", age: 22)
    let adele = Pet(name: "Adele", age: 27)
    let pets = [taylor, paul, justin, adele]
    
    let sortedPet = pets.sorted { $0.name < $1.name }
    
    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kochanski"),
        User(firstName: "David", lastName: "Lister"),
    ].sorted()
    
    
    let names = ["Taylor", "Paul", "Adele", "Justin"]
    print(names)
    let sorted = Array(names.sorted().reversed())
    print(sorted)
}

func compositionFunction() {
    let london = (name: "London", continent: "Europe", population: 8_539_000)
    let paris = (name: "Paris", continent: "Europe", population: 2_244_000)
    let lisbon = (name: "Lisbon", continent: "Europe", population: 530_000)
    let rome = (name: "Rome", continent: "Europe", population: 2_627_000)
    let tokyo = (name: "Tokyo", continent: "Asia", population: 13_350_000)
    let cities = [london, paris, lisbon, rome, tokyo]
    
    let europePopulation = cities
        .filter { $0.continent == "Europe" }
        .reduce(0) { $0 + $1.population }
}


