//
//  VariadicFunction.swift
//  Programming
//
//  Created by ke on 2024/5/22.
//

import Foundation

struct VariadicFunction {
    func addNumbers(numbers: Int...) -> Int {
        var total = 0
        for number in numbers {
            total += number
    }
        return total
    }
    
    func testAddNumbers() {
        addNumbers(numbers: 1, 2, 3, 4, 5)
    }
}
