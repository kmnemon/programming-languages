//
//  AsyncStreamExample.swift
//  Programming
//
//  Created by ke on 2025/1/7.
//

import Foundation
/*
 AsyncStream inherits all the default behaviors of AsyncSequence and lets you easily create streams of values by using either of these two custom initializers:

 • init(_:bufferingPolicy:_:): Creates a new stream that produces values of the given type, by the given closure. Your closure can control the sequence via a structure called a continuation. Use this variant when you want to pass the continuation to existing, non-async code such as a completion handler or delegate.

 • init(unfolding:onCancel:): Creates a new stream that produces values by returning them from the unfolding closure. It optionally executes an onCancel closure when it’s canceled. You would use this variant when wrapping async code as a sequence.
*/

struct AsyncStreamExample {
    static func SimpleAsyncStream() async{
        let stream = AsyncStream { continuation in
            for i in 1...9 {
                continuation.yield(i)
            }

            continuation.finish()
        }

        for await item in stream {
            print(item)
        }
    }
}
