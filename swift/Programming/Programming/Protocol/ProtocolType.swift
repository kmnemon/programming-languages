//
//  ProtocolType.swift
//  Programming
//
//  Created by ke on 12/9/25.
//

//1. protocol additional function

public protocol Equa {
    static func == (lhs: Self, rhs: Self) -> Bool
}

extension Equa {
    public static func != (lhs: Self, rhs: Self) -> Bool {
        return !(lhs == rhs)
    }
}

//2. protocol constraint
extension Sequence where Element: Comparable {
    
}

//3. conditional conformance
struct A<Element: Equatable> {
}

extension A: Equatable where Element: Equatable {
}
