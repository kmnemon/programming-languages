//
//  operator.swift
//  Programming
//
//  Created by ke on 2024/11/6.
//

//Int type operator overloading
extension BinaryInteger {
    static func *(lhs: Self, rhs: Double) -> Double {
        return Double(lhs) * rhs
    }
    
    static func *(lhs: Double, rhs:Self) -> Double {
        return lhs * Double(rhs)
    }
}
