//
//  TaskLocal.swift
//  Programming
//
//  Created by ke on 2025/1/6.
//

import Foundation

/*
 https://www.hackingwithswift.com/quick-start/concurrency/how-to-create-and-use-task-local-values
 Task-local values are analogous to thread-local values in an old-style multithreading environment: we attach some metadata to our task, and any code running inside that task can read that data as needed.
 
 Swift’s implementation is carefully scoped so that you create contexts where the data is available, rather than just injecting it directly into the task, which makes it possible to adjust your metadata over time. However, inside that context all code is able to read your task-local values, regardless of how it’s used.
 
 Using task-local values happens in three steps:
 
 1.Creating a type that has one or more properties we want to make into task-local values. This can be an enum, struct, class, or even actor if you want, but I’d suggest starting with an enum so it’s clear you don’t intend to make instances of the type.
 2.Marking each of your task-local values with the @TaskLocal property wrapper. These properties can be any type you want, including optionals, but must be marked as static.
 3.Starting a new task-local scope using YourType.$yourProperty.withValue(someValue) { … }.
 binding a task-local value makes it available not only to the immediate task, but also to all its child tasks:
 
 important tips:
 1.It’s okay to access a task-local value outside of a withValue() scope – you’ll just get back whatever default value you gave it.
 2.Although regular tasks inherit task-local values of their parent task, detached tasks do not because they don’t have a parent.
 3.Task-local values are read-only; you can only modify them by calling withValue() as shown above.
 And finally, one important quote from the Swift Evolution proposal for this feature: “please be careful with the use of task-locals and don't use them in places where plain-old parameter passing would have done the job.” Put more plainly, if task locals are the answer, there’s a very good chance you’re asking the wrong question.
 */

import Foundation

//1. Usage
extension TaskLocalExample {
    class User {
        @TaskLocal static var id = "Anonymous"
    }
}


struct TaskLocalExample {
    static func tasklocal() async throws {
        let first = Task {
            try await User.$id.withValue("Piper") {
                print("Start of task: \(User.id)")
                try await Task.sleep(for: .seconds(1))
                print("End of task: \(User.id)")
            }
        }
        
        let second = Task {
            try await User.$id.withValue("Alex") {
                print("Start of task: \(User.id)")
                try await Task.sleep(for: .seconds(1))
                print("End of task: \(User.id)")
            }
        }
        
        print("Outside of tasks: \(User.id)")
        try await first.value
        try await second.value
    }
}


//2. real example
/*
 in real-world code, task-local values are useful for places where you need to repeatedly pass values around inside your tasks – values that need to be shared within the task, but not across your whole program like a singleton might be
 */

enum LogLevel: Comparable {
    case debug, info, warn, error, fatal
}

struct Logger {
    // The log level for an individual task
    @TaskLocal static var logLevel = LogLevel.info
    
    // Make this struct a singleton
    private init() { }
    static let shared = Logger()
    
    // Print out a message only if it meets or exceeds our log level.
    func write(_ message: String, level: LogLevel) {
        if level >= Logger.logLevel {
            print(message)
        }
    }
}

struct TaskLocalExample2 {
    static func fetch(url urlString: String) async throws -> String? {
        Logger.shared.write("Preparing request: \(urlString)", level: .debug)
        
        if let url = URL(string: urlString) {
            let (data, _) = try await URLSession.shared.data(from: url)
            Logger.shared.write("Received \(data.count) bytes", level: .info)
            return String(decoding: data, as: UTF8.self)
        } else {
            Logger.shared.write("URL \(urlString) is invalid", level: .error)
            return nil
        }
    }
    
    // Starts a couple of fire-and-forget tasks with different log levels.
    static func tasklocal() async throws {
        let first = Task {
            try await Logger.$logLevel.withValue(.debug) {
                try await fetch(url: "https://hws.dev/news-1.json")
            }
        }
        
        let second = Task {
            try await Logger.$logLevel.withValue(.error) {
                try await fetch(url: "")
            }
        }
        
        _ = try await first.value
        _ = try await second.value
    }
}
