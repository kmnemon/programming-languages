//
//  FunctionProgramming.swift
//  Programming
//
//  Created by ke on 2024/7/25.
//

import Foundation

//Functional programming - Programming without assignment statements.

//non-funcitonal
var n: Int = 1
var sum: Int = 0

func done() -> Bool {
    return n > 10
}

func doSomething() {
    sum += n * n
    ++n
}

func sumFirstTenSquaresNonFunctional() {
    while !done() {
        doSomething()
    }
}


//functional
func sumFirstTenSquaresHelper(sum: Int, i: Int) -> Int {
    if i > 10 {
        return sum
    }
    return sumFirstTenSquaresHelper(sum+i*i, i+1)
}

func sumFirstTenSquares()-> Int {
    return sumFirstTenSquaresHelper(0, 1)
}

