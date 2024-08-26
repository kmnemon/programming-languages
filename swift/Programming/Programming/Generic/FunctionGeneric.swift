//
//  FunctionGeneric.swift
//  Programming
//
//  Created by ke on 2024/5/20.
//

import Foundation

//1.generic function
func inspect<T>(value: T) {
    print("Received \(value) with the value \(value)")
}


//2.constraint type
protocol Numeric {
    static func *(lhs: Self, rhs: Self) -> Self
}

extension Float: Numeric {}
extension Double: Numeric {}
extension Int: Numeric {}

func squareSomething<T: Numeric>(value: T) -> T {
    return value * value
}

