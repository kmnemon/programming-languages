//
//  TaskGroupCancel.swift
//  Programming
//
//  Created by ke on 2025/1/14.
//

import Foundation

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
}

