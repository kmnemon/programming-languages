//
//  URLExample.swift
//  Programming
//
//  Created by ke on 2025/1/10.
//

import Foundation


struct AsyncSequenceExample {
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
    
    //3.AsyncMapSequence
    func shoutQuotes() async throws {
        let url = URL(string: "https://hws.dev/quotes.txt")!
        let uppercaseLines = url.lines.map(\.localizedUppercase)

        for try await line in uppercaseLines {
            print(line)
        }
    }
    
    //4.AsyncMapSequence
    struct Quote {
        let text: String
    }

    func printQuotes() async throws {
        let url = URL(string: "https://hws.dev/quotes.txt")!

        let quotes = url.lines.map(Quote.init)

        for try await quote in quotes {
            print(quote.text)
        }
    }
    
    //5.filter
    func printAnonymousQuotes() async throws {
        let url = URL(string: "https://hws.dev/quotes.txt")!
        let anonymousQuotes = url.lines.filter { $0.contains("Anonymous") }

        for try await line in anonymousQuotes {
            print(line)
        }
    }

    //6.prefix
    func printTopQuotes() async throws {
        let url = URL(string: "https://hws.dev/quotes.txt")!
        let topQuotes = url.lines.prefix(5)

        for try await line in topQuotes {
            print(line)
        }
    }
    
    //7.combine
    // -AsyncMapSequence
    // -AsyncFilterSequence
    // -AsyncPrefixSequence
    func printQuotes2() async throws {
        let url = URL(string: "https://hws.dev/quotes.txt")!

        let anonymousQuotes = url.lines.filter { $0.contains("Anonymous") }
        let topAnonymousQuotes = anonymousQuotes.prefix(5)
        let shoutingTopAnonymousQuotes = topAnonymousQuotes.map(\.localizedUppercase)

        for try await line in shoutingTopAnonymousQuotes {
            print(line)
        }
    }
    
    //8.example
    func checkQuotes() async throws {
        let url = URL(string: "https://hws.dev/quotes.txt")!
        let noShortQuotes = try await url.lines.allSatisfy { $0.count > 30 }
        print(noShortQuotes)
    }
    
    //9.example
    func printHighestNumber() async throws {
        let url = URL(string: "https://hws.dev/random-numbers.txt")!

        if let highest = try await url.lines.compactMap(Int.init).max() {
            print("Highest number: \(highest)")
        } else {
            print("No number was the highest.")
        }
    }
    
    //10.
    func sumRandomNumbers() async throws {
        let url = URL(string: "https://hws.dev/random-numbers.txt")!
        let sum = try await url.lines.compactMap(Int.init).reduce(0, +)
        print("Sum of numbers: \(sum)")
    }
    
}
