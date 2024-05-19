//
//  Type.swift
//  Programming
//
//  Created by ke on 2024/5/17.
//

import Foundation

struct Dog: Comparable {
    var breed: String
    var age: Int
}

func <(lhs: Dog, rhs: Dog) -> Bool {
    return lhs.age < rhs.age
}
func ==(lhs: Dog, rhs: Dog) -> Bool {
    return lhs.age == rhs.age
}


enum Color {
    case Unknown, Blue, Red, Green, Pink
    
    var description: String {
        switch self {
        case .Unknown:
            return "the color is magic"
        case .Blue:
            return ""
        case .Red:
            return ""
        default:
            return ""
        }
    }
    
    func boys() -> Bool {
        return true
    }
    
    func girls() -> Bool {
        return false
    }
}

class ArrayType {
    var names = ["Taylor", "Timothy", "Tyler", "Thomas", "Tobias", "Tabitha"]
    var numbers = [5, 3, 1, 9, 5, 2, 7, 8]
    
    let poppy = Dog(breed: "Poodle", age: 5)
    let rusty = Dog(breed: "Labrador", age: 2)
    let rover = Dog(breed: "Corgi", age: 11)
    
    let alnord = Dog(breed: "Sheep", age: 16)
    
    func sorted() {
        let sorted = names.sorted()
        print(sorted)
        
        let sorted2 = names.sorted {
            return $0 < $1
        }
        
        print(sorted2)
    }
    
    func minMax() {
        let lowest = numbers.min()
        let highest = numbers.max()
    }
    
    func comparableDogs() {
        var dogs: [Dog] = [poppy, rusty, rover]
        dogs = dogs.sorted()
    }
    
    func insertRemoveDogs() {
        var dogs: [Dog] = [poppy, rusty, rover]
        dogs += [alnord]
        
        var dog1 = dogs.removeLast()
        if let dog2 = dogs.popLast(){
            
        }
        
        var dog3 = dogs.removeFirst()
    }
    
    func emptyAndCapacity() {
        var dogs: [Dog] = [poppy, rusty, rover]

        if dogs.isEmpty {
                
        }
        
        if dogs.count == 0 {
            
        }
        
        //O(n) - be careful the ios will copy all item to a contiguous storage
        dogs.reserveCapacity(30)
    }
    
    func contiguousArray() {
        let array = ContiguousArray<Int>(1...1000000)

    }
}

class SetType {
    var s: Set = ["aaa", "bbb", "ccc"]
    var s2: Set = Set(1...100)
    var a1: [String] = ["aaa", "bbb", "ccc"]
    
    func sets() {
        s.insert("ddd")
        s = [] //clear
        
        if s.contains("aaa"){
            
        }
        
        s.remove("bbb")
    }
    
    func ArrayTransferSets() {
        var s3 = Set(a1)
        var a4 = Array(s3)
    }
    
    func loopSet() {
        var s: Set = ["aaa", "bbb", "ccc"]
        for str in s {
            print(str)
        }
        
        for str in s.sorted() {
            print(str)
        }
    }
}



class DictionaryType {
    func dictionary1() {
        var d: [String: String] = [:]
        
        if let oldValue = d.updateValue("duke", forKey: "123") {
            print("old value is \(oldValue)")
        }
        
        print(d["123"]!)
    }
    
}
