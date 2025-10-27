//
//  Function.swift
//  Programming
//
//  Created by ke on 10/27/25.
//

//1. all the sort
func allTheSort() {
    var myArray = [3, 1, 2]
    
    //1.non mutate
    var sortedArray = myArray.sorted() //1, 2, 3
    
    sortedArray = myArray.sorted(by: >) //3, 2, 1
    
    //2.mutate
    myArray.sort()
    myArray.sort(by: > )
    
    //3.complicated sort by some criteria
    let animals = ["elephant", "zebra", "dog"]
    animals.sorted { lhs, rhs in
        let l = lhs.reversed()
        let r = rhs.reversed()
        return l.lexicographicallyPrecedes(r)
    }
    
    
    
    
}
