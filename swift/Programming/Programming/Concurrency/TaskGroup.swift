//
//  TaskGroup.swift
//  Programming
//
//  Created by ke on 2025/1/14.
//

import Foundation
import SwiftUI

//example 1:
struct TaskGroup {
    func simpleTaskGroup() async {
        let string = await withTaskGroup(of: String.self) { group in
            group.addTask { "Hello" }
            group.addTask { "From" }
            group.addTask { "A" }
            group.addTask { "Task" }
            group.addTask { "Group" }
            
            var collected = [String]()
            
            for await value in group {
                collected.append(value)
            }
            
            return collected.joined(separator: " ")
        }
        
        print(string)
    }
    
    
    //example 2:
    struct NewsStory: Decodable, Identifiable {
        let id: Int
        let title: String
        let strap: String
        let url: URL
    }
    
    struct NewsStoryView: View {
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
                stories = try await withThrowingTaskGroup(of: [NewsStory].self) { group in
                    for i in 1...5 {
                        group.addTask {
                            let url = URL(string: "https://hws.dev/news-\(i).json")!
                            let (data, _) = try await URLSession.shared.data(from: url)
                            return try JSONDecoder().decode([NewsStory].self, from: data)
                        }
                    }
                    
                    var allStories = [NewsStory]()
                    
                    for try await stories in group {
                        allStories.append(contentsOf: stories)
                    }
                    
                    return allStories.sorted { $0.id > $1.id }
                }
            } catch {
                print("Failed to load stories")
            }
        }
    }
    

}
