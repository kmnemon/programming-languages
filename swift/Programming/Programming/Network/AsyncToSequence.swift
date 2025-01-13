//
//  AsyncToSequence.swift
//  Programming
//
//  Created by ke on 2025/1/13.
//

import Foundation

extension AsyncSequence {
    func collect() async throws -> [Element] {
        try await reduce(into: [Element]()) { $0.append($1) }
    }
}

func getNumberArray() async throws -> [Int] {
    let url = URL(string: "https://hws.dev/random-numbers.txt")!
    let numbers = url.lines.compactMap(Int.init)
    return try await numbers.collect()
}

func applyAsyncToSequence() async {
    if let numbers = try? await getNumberArray() {
        for number in numbers {
            print(number)
        }
    }
}
