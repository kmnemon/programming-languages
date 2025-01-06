//
//  TaskLocal.swift
//  Programming
//
//  Created by ke on 2025/1/6.
//

import Foundation

/*
 
 Task-local values are analogous to thread-local values in an old-style multithreading environment: we attach some metadata to our task, and any code running inside that task can read that data as needed.
 
 Swift’s implementation is carefully scoped so that you create contexts where the data is available, rather than just injecting it directly into the task, which makes it possible to adjust your metadata over time. However, inside that context all code is able to read your task-local values, regardless of how it’s used.
 
 Using task-local values happens in three steps:
 
 Creating a type that has one or more properties we want to make into task-local values. This can be an enum, struct, class, or even actor if you want, but I’d suggest starting with an enum so it’s clear you don’t intend to make instances of the type.
 Marking each of your task-local values with the @TaskLocal property wrapper. These properties can be any type you want, including optionals, but must be marked as static.
 Starting a new task-local scope using YourType.$yourProperty.withValue(someValue) { … }.
 binding a task-local value makes it available not only to the immediate task, but also to all its child tasks:
 */

import Foundation

//1. Usage
extension TaskLocal {
    class User {
        @TaskLocal static var id = "Anonymous"
    }
}


struct TaskLocal {
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
