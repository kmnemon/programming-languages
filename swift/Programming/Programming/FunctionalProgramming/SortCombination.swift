//
//  SortCombination.swift
//  Programming
//
//  Created by ke on 10/28/25.
//

import Foundation

struct Person2 {
    let first: String
    let last: String
    let yearOfBirth: Int
}

let people = [
    Person2(first: "Emily", last: "Young", yearOfBirth: 2002),
    Person2(first: "David", last: "Gray", yearOfBirth: 1991),
    Person2(first: "Robert", last: "Barnes", yearOfBirth: 1985),
    Person2(first: "Ava", last: "Barnes", yearOfBirth: 2000),
    Person2(first: "Joanne", last: "Miller", yearOfBirth: 1994),
]


struct SortDescriptor<Root> {
    var areInIncreasingOrder: (Root, Root) -> Bool
}

extension SortDescriptor {
    init<Value: Comparable>(_ key: @escaping (Root) -> Value) {
        self.areInIncreasingOrder = { key($0) < key($1) }
    }
}

extension SortDescriptor {
    init<Value>(_ key: @escaping (Root) -> Value,
                by compare: @escaping (Value) -> (Value) -> ComparisonResult) {
        self.areInIncreasingOrder = {
            compare(key($0))(key($1)) == .orderedAscending
        }
    }
    
    func then(_ other: SortDescriptor<Root>) -> SortDescriptor<Root> {
        SortDescriptor { x, y in
            if areInIncreasingOrder(x, y) { return true }
            if areInIncreasingOrder(y, x) { return false }
            return other.areInIncreasingOrder(x, y)
        }
    }
}

func usage2() {
    let sortByFirstName: SortDescriptor<Person2> = .init ({ $0.first }, by: String.localizedStandardCompare )
    let sortByLastName: SortDescriptor<Person2> = .init ({ $0.last }, by: String.localizedStandardCompare )
    let sortByYear: SortDescriptor<Person2> = .init { $0.yearOfBirth }
    
    let combined = sortByLastName.then(sortByFirstName).then(sortByYear)
    
    people.sorted(by: combined.areInIncreasingOrder)
    
}
