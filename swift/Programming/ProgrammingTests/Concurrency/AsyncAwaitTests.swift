//
//  AsyncAwaitTests.swift
//  Programming
//
//  Created by ke on 2024/11/19.
//

import Testing

@Suite("AsyncAwait") struct AsyncAwaitTests {
    @Test func testAsyncAwait() async throws {
        await #expect(throws: (any Error).self) {
            try await AsyncAwait.availableSymbols()
        }
    }
}
