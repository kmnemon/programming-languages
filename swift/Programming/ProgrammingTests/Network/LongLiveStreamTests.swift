//
//  LongLiveStreamTests.swift
//  Programming
//
//  Created by ke on 1/4/25.
//
import Testing

struct LongLiveStreamTests {
    @Test func testLongLiveStream() async {
        do {
            try await LongLiveStream.longLiveStream()
        } catch {
            print("error")
        }
        print("finishd")
    }
}
