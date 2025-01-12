//
//  URLExample.swift
//  Programming
//
//  Created by ke on 2025/1/10.
//

import Foundation


struct LinesAndIterator {
    //1. url.lines - AsyncLineSequence
    func fetchUsers() async throws {
        let url = URL(string: "https://hws.dev/users.csv")!
        
        for try await line in url.lines {
            print("Received user: \(line)")
        }
    }
    // try? await fetchUsers()
    
    //2. iterator
    func printUsers() async throws {
        let url = URL(string: "https://hws.dev/users.csv")!

        var iterator = url.lines.makeAsyncIterator()

        if let line = try await iterator.next() {
            print("The first user is \(line)")
        }

        for i in 2...5 {
            if let line = try await iterator.next() {
                print("User #\(i): \(line)")
            }
        }

        var remainingResults = [String]()

        while let result = try await iterator.next() {
            remainingResults.append(result)
        }

        print("There were \(remainingResults.count) other users.")
    }
    // try? await printUsers()
    
}
