//
//  AsyncStreamExample.swift
//  Programming
//
//  Created by ke on 1/13/25.
//

import Foundation
/*
 AsyncStream inherits all the default behaviors of AsyncSequence and lets you easily create streams of values by using either of these two custom initializers:
 
 • init(_:bufferingPolicy:_:): Creates a new stream that produces values of the given type, by the given closure. Your closure can control the sequence via a structure called a continuation. Use this variant when you want to pass the continuation to existing, non-async code such as a completion handler or delegate.
 
 • init(unfolding:onCancel:): Creates a new stream that produces values by returning them from the unfolding closure. It optionally executes an onCancel closure when it’s canceled. You would use this variant when wrapping async code as a sequence.
 */

struct AsyncStreamExample {
    func simpleAsyncStream() async {
        let stream = AsyncStream { continuation in
            for i in 1...9 {
                continuation.yield(i)
            }
            
            //Any values yielded after calling finish() on your continuation will be ignored.
            continuation.finish()
        }
        
        for await item in stream {
            print(item)
        }
    }
    
    
    /*
     1.You can asynchronously read values from the stream.
     2.You can concurrently read values from the stream.
     3.You can also asynchronously add values into the stream.
     */
    
    //1.
    func asyncRead1a() async {
        let stream = AsyncStream { continuation in
            for i in 1...9 {
                continuation.yield(i)
            }
            
            continuation.finish()
        }
        
        for _ in 1...3 {
            print("The next three are:")
            
            for await item in stream.prefix(3) {
                print(item)
            }
        }
    }
    
    func asyncRead1b() async {
        let stream = AsyncStream { continuation in
            for i in 1...9 {
                continuation.yield(i)
            }
            
            continuation.finish()
        }
        
        let firstThree = stream.prefix(3)
        
        for _ in 1...3 {
            print("The next three are:")
            
            for await item in firstThree {
                print(item)
            }
        }
    }
    
    
    //2.
    func concurrentRead() async {
        let stream = AsyncStream { continuation in
            for i in 1...9 {
                continuation.yield(i)
            }
            
            continuation.finish()
        }
        
        Task {
            for await item in stream {
                print("1. \(item)")
            }
        }
        
        Task {
            for await item in stream {
                print("2. \(item)")
            }
        }
        
        Task {
            for await item in stream {
                print("3. \(item)")
            }
        }
        
        try? await Task.sleep(for: .seconds(1))
    }
    
    //3.
    func asyncAdd() async {
        let stream = AsyncStream { continuation in
            for i in 1...3 {
                Task {
                    try await Task.sleep(for: .seconds(i))
                    continuation.yield(i)
                    
                    if i == 3 {
                        continuation.finish()
                    }
                }
            }
        }
        
        for await item in stream {
            print(item)
        }
    }
    
    
    /*
     buffering policies:
     1.The default buffering policy is .unbounded, which means you can add as many values to your stream as you want, and they'll all wait to be read.
     2.The .bufferingNewest() policy means the stream should retain only some number of values, discarding older values once a buffer size has been reached.
     3.The .bufferingOldest() policy means the stream will read values in until the buffer is full, and will ignore any further new values until the older values have been read
     */
    func bufferingNewest() async {
        let stream = AsyncStream(bufferingPolicy: .bufferingNewest(5)) { continuation in
            for i in 1...9 {
                continuation.yield(i)
            }

            continuation.finish()
        }

        for await item in stream {
            print(item)
        }
    }
    
    
    /*
     AsyncThrowingStream is useful for places when the work you will do might finish early by throwing an error. This will end the stream immediately – all previous values will be sent back as normal, but no future values will.
     */
    enum MultipleError: Error {
        case no3
    }
    
    func AsyncThrowing() async throws {
        let stream = AsyncThrowingStream { continuation in
            for i in 1...40 {
                continuation.yield(i)

                if i.isMultiple(of: 3) {
                    continuation.finish(throwing: MultipleError.no3)
                }
            }

            continuation.finish()
        }
        
        //apply
        do {
            for try await values in stream {
                print(values)
            }
        } catch {
            print("Error received: \(error)")
        }
    }
}
