//
//  Iterator.swift
//  Programming
//
//  Created by ke Liu on 12/17/25.
//

//1. Iterator Protocol has value sematic
struct FibsIterator: IteratorProtocol {
    var state = (0, 1)
    mutating func next() -> Int? {
        let upcomingNumber = state.0
        state = (state.1, state.0 + state.1)
        return upcomingNumber
    }
}

//2. AnyIterator Protocol has reference sematic
func fibsIterator() -> AnyIterator<Int> {
    var state = (0, 1)
    return AnyIterator {
        let upcomingNumber = state.0
        state = (state.1, state.0 + state.1)
        return upcomingNumber
    }
}

//3. Iterator is a single pass sequence
/*
 Every iterator can also be seen as a single-pass sequence over the elements it has yet to return. As a matter of fact, you can turn every iterator into a sequence simply by declaring conformance; Sequence comes with a default implementation for makeIterator that returns self if the conforming type is an iterator:
 extension Sequence where Iterator == Self {
 func makeIterator() -> Self {
 return self
 }
 }
 */

struct FibsIterator2: IteratorProtocol, Sequence {
    var state = (0, 1)

    mutating func next() -> Int? {
        let value = state.0
        state = (state.1, state.0 + state.1)
        return value
    }
    
    //default implement
//    func makeIterator() -> Self {
//        return self
//    }
}
