//
//  FunctionProgramming.swift
//  Programming
//
//  Created by ke on 2024/7/25.
//

import Foundation

//Functional programming - Programming without assignment statements(without variables).
//functional programs are composed of true mathematical, referentially transparent functions

//non-funcitonal
var n: Int = 1
var sum: Int = 0

func done() -> Bool {
    return n > 10
}

func doSomething() {
    sum += n * n
    n += 1
}

func sumFirstTenSquaresNonFunctional() {
    while !done() {
        doSomething()
    }
}


//functional
func sumFirstTenSquaresHelper(_ sum: Int, _ i: Int) -> Int {
    if i > 10 {
        return sum
    }
    return sumFirstTenSquaresHelper(sum+i*i, i+1)
}

func sumFirstTenSquares()-> Int {
    return sumFirstTenSquaresHelper(0, 1)
}


