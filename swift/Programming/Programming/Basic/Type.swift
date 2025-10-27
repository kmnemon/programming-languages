//
//  Type.swift
//  Programming
//
//  Created by ke on 2024/10/22.
//
import Foundation

//1. use for money
func MoneyType() {
    var m: Decimal
    m = Decimal(1.1) / 2
    print(m)
}

//2. Int type extension, work on any integer
extension BinaryInteger {
    var isEven: Bool { return self%2 == 0 }
}

//3. define a function for all integer type
func isEven<T: BinaryInteger>(_ i: T) -> Bool {
    return i%2 == 0
}

/*
 4.If you want to assign that free function to a variable, this is also when you’d have to lock down which specific types it’s operating on. A variable can’t hold a generic function — only a specific one
 */
let int8IsEven: (Int8) -> Bool = isEven
