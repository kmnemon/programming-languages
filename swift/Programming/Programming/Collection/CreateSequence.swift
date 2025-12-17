//
//  CreateSequence.swift
//  Programming
//
//  Created by ke Liu on 12/17/25.
//


func createSequence() {
    //1. create Sequence
    struct FibsSequence: Sequence {
        func makeIterator() -> FibsIterator {
            FibsIterator()
        }
    }
    
    //1b. create Sequence
    let seq = stride(from: 0, to: 10, by: 1)
    var i1 = seq.makeIterator()
    i1.next()// Optional(0)
    
    //2. create AnySequence
    let fibsSequence = AnySequence(fibsIterator)
    print(Array(fibsSequence.prefix(10))) // [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
    
    //3. sequence(first:next:), return unfold sequence, which means expand a single value to generate a sequence
    //reduce - fold, which means reduces a sequence to a single value
    let numbers = sequence(first: 1) { previous in
        previous + 2
    }
    
    for n in numbers.prefix(5) {
        print(n)
    }
    
    //4. sequence(state:next:)
    let fibsSequence2 = sequence(state: (0, 1)) { state -> Int? in
        let upcomingNumber = state.0
        state = (state.1, state.0 + state.1)
        return upcomingNumber
    }
    print(Array(fibsSequence2.prefix(10))) // [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
}



