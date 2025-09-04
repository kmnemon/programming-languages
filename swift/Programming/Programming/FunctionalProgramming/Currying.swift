//
//  Currying.swift
//  Programming
//
//  Created by ke Liu on 9/4/25.
//

func curriedAdd(_ a: Int) -> (Int) -> Int {
    return { a + $0 }
}

let addTwo = curriedAdd(2)
let result1 = addTwo(3)
