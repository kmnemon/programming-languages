//
//  TaskGroupCancel.swift
//  Programming
//
//  Created by ke on 2025/1/14.
//

import Foundation
import SwiftUI

struct TaskGroupCancel {
    //Cancel Task
    /*Swift’s task groups can be cancelled in one of three ways:
     1.if the parent task of the task group is cancelled,
     2.if you explicitly call cancelAll() on the group,
     3.if one of your child tasks throws an uncaught error, all remaining tasks will be implicitly cancelled.
     */
    //example1:
    func simpleTaskGroupCancel() async {
        let result = await withThrowingTaskGroup(of: String.self) { group in
            group.addTask {
                try Task.checkCancellation() //check cancellation
                return "Testing"
            }
            group.addTask { "Group" }
            group.addTask { "Cancellation" }
            
            group.cancelAll()
            var collected = [String]()
            
            do {
                for try await value in group {
                    collected.append(value)
                }
            } catch {
                print(error.localizedDescription)
            }
            
            return collected.joined(separator: " ")
        }
        
        print(result)
    }
    
    //example2:
    struct NewsStory: Identifiable, Decodable {
        let id: Int
        let title: String
        let strap: String
        let url: URL
    }
    
    struct NewsStoryView2: View {
        @State private var stories = [NewsStory]()
        
        var body: some View {
            NavigationStack {
                List(stories) { story in
                    VStack(alignment: .leading) {
                        Text(story.title)
                            .font(.headline)
                        
                        Text(story.strap)
                    }
                }
                .navigationTitle("Latest News")
            }
            .task {
                await loadStories()
            }
        }
        
        func loadStories() async {
            do {
                try await withThrowingTaskGroup(of: [NewsStory].self) { group in
                    for i in 1...5 {
                        group.addTask {
                            let url = URL(string: "https://hws.dev/news-\(i).json")!
                            let (data, _) = try await URLSession.shared.data(from: url)
                            try Task.checkCancellation()
                            return try JSONDecoder().decode([NewsStory].self, from: data)
                        }
                    }
                    
                    for try await result in group {
                        if result.isEmpty {
                            group.cancelAll()
                        } else {
                            stories.append(contentsOf: result)
                        }
                    }
                    
                    stories.sort { $0.id < $1.id }
                }
            } catch {
                print("Failed to load stories: \(error.localizedDescription)")
            }
        }
    }
    
    //example 3: cancel task group using childtask throw an error
    enum ExampleError: Error {
        case badURL
    }

    func testCancellation() async {
        do {
            try await withThrowingTaskGroup(of: Void.self) { group in
                group.addTask {
                    try await Task.sleep(for: .seconds(1))
                    throw ExampleError.badURL
                }

                group.addTask {
                    try await Task.sleep(for: .seconds(2 ))
                    print("Task is cancelled: \(Task.isCancelled)")
                }

                try await group.next()
            }
        } catch {
            print("Error thrown: \(error.localizedDescription)")
        }
    }
    
    //example 4: addTaskUnlessCancelled
    /*
     If you want to avoid adding tasks to a cancelled group, use the addTaskUnlessCancelled() method instead – it works identically except will do nothing if called on a cancelled group. Calling addTaskUnlessCancelled() returns a Boolean that will be true if the task was successfully added, or false if the task group was already cancelled
     */
    func addTaskUnlessCancelledExample() async {
        do {
            try await withThrowingTaskGroup(of: Void.self) { group in
                let r = group.addTaskUnlessCancelled {
                    try await Task.sleep(for: .seconds(1))
                    throw ExampleError.badURL
                }

                try await group.next()
            }
        } catch {
            print("Error thrown: \(error.localizedDescription)")
        }
    }
}

