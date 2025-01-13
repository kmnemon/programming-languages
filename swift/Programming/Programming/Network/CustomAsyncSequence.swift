//
//  CustomAsyncSequence.swift
//  Programming
//
//  Created by ke on 2025/1/13.
//

import Foundation
import SwiftUI

//example 1a:
struct DoubleGenerator: AsyncSequence, AsyncIteratorProtocol {
    var current = 1

    /*
     &*= multiplies with overflow, meaning that rather than running out of room when the value goes beyond the highest number of a 64-bit integer, it will instead flip around to be negative. We use this to our advantage, returning nil when we reach that point.
     */
    mutating func next() async -> Int? {
        defer { current &*= 2 }

        if current < 0 {
            return nil
        } else {
            return current
        }
    }

    func makeAsyncIterator() -> DoubleGenerator {
        self
    }
}

//example 1b:
struct DoubleGenerator2: AsyncSequence {
    struct AsyncIterator: AsyncIteratorProtocol {
        var current = 1

        mutating func next() async -> Int? {
            defer { current &*= 2 }

            if current < 0 {
                return nil
            } else {
                return current
            }
        }
    }

    func makeAsyncIterator() -> AsyncIterator {
        AsyncIterator()
    }
}

func applyAsyncSequence() async {
    let sequence = DoubleGenerator()

    for await number in sequence {
        print(number)
    }
}

//realistic example 2:
struct URLWatcher: AsyncSequence, AsyncIteratorProtocol {
    let url: URL
    let delay: Int
    private var comparisonData: Data?
    private var isActive = true

    init(url: URL, delay: Int = 10) {
        self.url = url
        self.delay = delay
    }

    mutating func next() async throws -> Data? {
        // Once we're inactive always return nil immediately
        guard isActive else { return nil }

        if comparisonData == nil {
            // If this is our first iteration, return the initial value
            comparisonData = try await fetchData()
        } else {
            // Otherwise, sleep for a while and see if our data changed
            while true {
                try await Task.sleep(for: .seconds(delay))
                let latestData = try await fetchData()

                if latestData != comparisonData {
                    // New data is different from previous data,
                    // so update previous data and send it back
                    comparisonData = latestData
                    break
                }
            }
        }

        if comparisonData == nil {
            isActive = false
            return nil
        } else {
            return comparisonData
        }
    }

    private func fetchData() async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }

    func makeAsyncIterator() -> URLWatcher {
        self
    }
}

//swiftui
// As an example of URLWatcher in action, try something like this:
struct User3: Identifiable, Decodable {
    let id: Int
    let name: String
}

struct ContentView: View {
    @State private var users = [User3]()

    var body: some View {
        List(users) { user in
            Text(user.name)
        }
        .task {
            // continuously check the URL watcher for data
            await fetchUsers()
        }
    }

    func fetchUsers() async {
        let url = URL(fileURLWithPath: "FILENAMEHERE.json")
        let urlWatcher = URLWatcher(url: url, delay: 3)

        do {
            for try await data in urlWatcher {
                try withAnimation {
                    users = try JSONDecoder().decode([User3].self, from: data)
                }
            }
        } catch {
            // just bail out
        }
    }
}
