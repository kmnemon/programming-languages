//
//  Lazy.swift
//  Programming
//
//  Created by ke on 2024/5/14.
//

import Foundation

class X{
    init() {
        print("X init")
    }
}

class Lazy {
    lazy var l = "Hello \(X())"
    
    func fibonacci(_ num: Int) -> Int {
        if num < 2 {
            return num
        } else {
            return fibonacci(num - 1) + fibonacci(num - 2)
        }
    }
    
    func calcFibonacci() {
        let fibonacciSequence = (0...199).lazy.map(fibonacci)
        print(fibonacciSequence)
    }
    

}
