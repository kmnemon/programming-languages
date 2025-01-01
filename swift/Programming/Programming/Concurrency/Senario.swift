//
//  Senario.swift
//  Programming
//
//  Created by ke on 1/1/25.
//

import Foundation

/* Senario 1: Concurrent
 */
func taskA() async -> Int {
    try! await Task.sleep(for: .seconds(2))
    return 5
}

func concurrentExample() async -> Int {
    async let resultA = taskA()
    async let resultB = taskA()
    
    let r1 = await resultA
    let r2 = await resultB
    return r1 + r2
}

/* Senario 2: Parallel
 */
func taskA1() async -> Int {
    try! await Task.sleep(for: .seconds(2))
    return 5
}
func taskB1(a1: Int) async -> Int {
    try! await Task.sleep(for: .seconds(2))
    return a1 + 2
}

func parallelExample1() async -> Int {
    var result = 0
    let taskCount = 5
    
    let taskAStream = AsyncStream<Int> { continuation in
        Task {
            for _ in 0..<taskCount {
                let taskAResult = await taskA1()
                continuation.yield(taskAResult)  // Yield the result as soon as it's ready
            }
            continuation.finish()  // Finish the stream when all taskA1 are done
        }
    }
    
    for await a1 in taskAStream {
        let b1Result = await taskB1(a1: a1)
        result += b1Result
    }
    
    return result
}

/* Senario 3: first Concurrent, then Parallel
 */
func taskA2() async -> Int {
    try! await Task.sleep(for: .seconds(2))
    return 5
}
func taskB2(a1: Int) async -> Int {
    try! await Task.sleep(for: .seconds(2))
    return a1 + 2
}

func concurrentWithParallelExample() async -> Int {
    var result = 0
    let taskCount = 5
    let streamCount = 2
    
    let taskAStream = AsyncStream<Int> { continuation in
        var c = 0
        Task {
            for _ in 0..<taskCount {
                let taskA2Result = await taskA2()
                continuation.yield(taskA2Result)  // Yield the result as soon as it's ready
            }
            c += 1
            if c == 2 {
                continuation.finish()
            }// Finish the stream when all taskA1 are done
        }
        
        Task {
            for _ in 0..<taskCount {
                let taskA2Result = await taskA2()
                continuation.yield(taskA2Result)  // Yield the result as soon as it's ready
            }
            c += 1
            if c == 2 {
                continuation.finish()  // Finish the stream when all taskA1 are done
            }
        }
    }
    
    for await a1 in taskAStream {
        let b2Result = await taskB2(a1: a1)
        result += b2Result
    }
    
    return result
}
