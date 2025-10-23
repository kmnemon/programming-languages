//
//  PatternMatch.swift
//  Programming
//
//  Created by ke Liu on 10/14/25.
//

func IfCase() {
    let j = 5
    if case 0..<10 = j {
        print("\(j) within range")
    }// 5 within range
}

func pickNonNil() {
    let numbers = ["1", "2", "three"]
    var sum = 0
    
    //1.pattern match
    for case let i? in numbers.map({ Int($0)}) {
        sum += i
    }
    
    print(sum) //3
    
    //2.map reduce way
    sum = numbers
        .map { Int($0) }
        .reduce(0) { $0 + ($1 ?? 0) }
}
