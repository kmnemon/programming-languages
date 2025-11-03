//
//  ProtocalGeneric.swift
//  Programming
//
//  Created by ke on 2024/5/21.
//

/*
 Basic Protocols
    Equatable - can compare with ==
    Comparable - can compare with <, >, etc.
    Hashable - can be hashed
    Identifiable - has id property
    CaseIterable - has allCases
 
 Numeric Protocols
    Numeric - basic numbers
    BinaryInteger - integer types
    FloatingPoint - floating point numbers
    SignedNumeric - signed numbers
    
 Collection Protocols
    Sequence - can be iterated
    Collection - indexed collection
    BidirectionalCollection - can go backwards
    RandomAccessCollection - random access
 
 String Protocols
    StringProtocol - String and Substring
    LosslessStringConvertible - can convert from string
    
 Other Protocols
    Codable - can encode/decode
    CustomStringConvertible - has custom string representation
    Error - can be used as error
 */

import Foundation

protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

struct IntStack: Container {
    // original IntStack implementation
    var items: [Int] = []
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    // conformance to the Container protocol
    typealias Item = Int
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}

