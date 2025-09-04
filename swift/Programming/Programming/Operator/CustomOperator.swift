//
//  CustomOperator.swift
//  Programming
//
//  Created by ke Liu on 9/4/25.
//
import Foundation
//1.infix
infix operator >>>
func >>> <A, B, C>(lhs: @escaping (A) -> B, rhs: @escaping (B) -> C) -> (A) -> C {
    return { rhs(lhs($0)) }
}

func addOne(_ number: Int) -> Int {
    return number + 1
}
func toString(_ number: Int) -> String {
    return String(number)
}

let addOneToString = addOne >>> toString
let result2 = addOneToString(3)

//2. prefix
prefix operator √

// Implement the square root magnitude operation
prefix func √ (vector: Vector2D) -> Double {
    return sqrt(vector.x * vector.x + vector.y * vector.y)
}

let magnitude = √vector1  // sqrt(9 + 1) = √10 ≈ 3.16


//3. postfix
postfix operator %

postfix func % (number: Double) -> Double {
    return number/100
}

let price: Double = 1000%

