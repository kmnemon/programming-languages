//
//  Array.swift
//  Programming
//
//  Created by ke on 9/29/25.
//

func arrayAppend() {
    var a = [1, 2, 3]
    a.append(4)
    a.append(contentsOf: [4, 5])
}

func arrayOper() {
    let arr = [1, 2, 3]
    
    //1. iterate over
    for x in arr {
       print(x)
    }
    
    //2. iterate over but the first element of array
    for x in arr.dropFirst() {
        print(x)
    }
    
    //3. iterate over but the last five
    for x in arr.dropLast(5) {
        print(x)
    }
    
    //4.number all the elements in an array
    for (num, element) in arr.enumerated() {
        print(num)
        print(element)
    }
    
    //5.iterate over indices and elements
    for (index, element) in zip(arr.indices, arr) {
        print(index)
        print(element)
    }
    
    //6. find the location of a specific element
    if let idx = arr.firstIndex( where: {
        someMatchingLogic($0)
    }) {
        print(idx)
    }
    
    

    
}

func someMatchingLogic(_ element: Int) -> Bool {
    return true
}


