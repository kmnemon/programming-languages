//
//  TaskGroupDiscard.swift
//  Programming
//
//  Created by ke on 1/16/25.
//

import Foundation
/*
 if you using withTaskGroup and the code never actually waits for tasks to complete, so they sit there, building up slowly – if you run that code back you'll it leaks about 0.5MB memory a second.
 using withDiscardingTaskGroup or withThrowingDiscardingTaskGroup won't leak memory any more, because old tasks will automatically be destroyed
 */
struct TaskGroupDiscard {
    struct RandomGenerator: AsyncSequence, AsyncIteratorProtocol {
        mutating func next() async -> Int? {
            try? await Task.sleep(for: .seconds(0.001))
            return Int.random(in: 1...Int.max)
        }

        func makeAsyncIterator() -> Self {
            self
        }
    }
    
    func discardResult() async {
        let generator = RandomGenerator()

        await withDiscardingTaskGroup { group in
            for await newNumber in generator {
                group.addTask {
                    print(newNumber)
                }
            }
        }
    }

    
}
