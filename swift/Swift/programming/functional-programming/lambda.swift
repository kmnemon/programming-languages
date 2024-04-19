//
//  lambda.swift
//  swift
//
//  Created by ke on 4/8/24.
//

import Foundation

func filterFunction() {
    let numbers = [1, 2, 3, 4, 5]
    let evens = numbers.filter { $0.isMultiple(of: 2) } // 2, 4
}

func mapFunction() {
    let numbers2 = ["1", "2", "fish", "3"]
    let evensMap = numbers2.map(Int.init)
    
    let evensCompactMap = numbers2.compactMap(Int.init)
}



