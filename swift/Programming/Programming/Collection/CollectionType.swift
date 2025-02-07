//
//  Collection.swift
//  Programming
//
//  Created by ke on 2024/5/24.
//

import Foundation

//1.basic
class CollectionType {
    func CollectionType() {
        //1.Arrays
        var apples: [String] = []
        print("some apples \(apples.count)")
        apples.append("jobs")
        
        var threeDoubles = Array(repeating: 0.0, count: 3)
        var twoDoubles = Array(repeating: 0.0, count: 2)
        
        //combine
        var combineDoubles = threeDoubles + twoDoubles
        
        
        //literal
        var shoppingList: [String] = ["Eggs", "Milk"]
        
        for item in shoppingList {
            print(item)
        }
        
        for (index, value) in shoppingList.enumerated() {
            print("Item \(index + 1): \(value)")
        }
        
        
        //2.Sets
        var lettes = Set<Character>()
        print("\(lettes.count)")
        
        lettes.insert("a")
        lettes = []
        
        //create a set with an array literal
        var favriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
        
        
        for genre in favriteGenres {
            print("\(genre)")
        }
        
        for genre in favriteGenres.sorted() {
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
        
        //3.Dictionaries
        var namesOfIntegers: [Int: String] = [:]
        
        namesOfIntegers[16] = "sixteen"
        namesOfIntegers = [:]
        
        var airports: [String: String] = ["YYX": "Toronto person", "DUB": "Dubin"]
        
    
        if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
            print("The old value for DUB was \(oldValue).")
        }
        
        if let airportName = airports["DUB"] {
            print("The name of the airport is \(airportName).")
        } else {
            print("That airport isn't in the airports dictionary.")
        }

        //remove
        if let removedValue = airports.removeValue(forKey: "DUB") {
            print("The removed airport's name is \(removedValue).")
        } else {
            print("The airports dictionary doesn't contain a value for DUB.")
        }

        for airportCode in airports.keys {
            print("Airport code: \(airportCode)")
        }
        
        for airportName in airports.values {
            print("Airport Name:\(airportName)")
        }
        
        //to array
        let airportCodes = [String](airports.keys)
        // airportCodes is ["LHR", "YYZ"]


        let airportNames = [String](airports.values)
        // airportNames is ["London Heathrow", "Toronto Pearson"]
    }


}

//2.Array[String] -> String
extension BidirectionalCollection where Element: StringProtocol {
    var serialized: String {
        count <= 2 ?
            joined(separator: " and ") :
            dropLast().joined(separator: ", ") + ", and " + last!
    }
}

