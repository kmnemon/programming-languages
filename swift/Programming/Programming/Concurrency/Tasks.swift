//
//  Tasks.swift
//  Programming
//
//  Created by ke on 2024/8/17.
//

import Foundation
/*
 1.Task(priority:operation): Schedules operation for asynchronous execution with the given priority. It inherits defaults from the current synchronous context.
 2.Task.detached(priority:operation): Similar to Task(priority:operation), except that it doesn’t inherit the defaults of the calling context.
 3.Task.value: Waits for the task to complete, then returns its value, similarly to a promise in other languages.
 4.Task.isCancelled: Returns true if the task was canceled since the last suspension point. You can inspect this boolean to know when you should stop the execution of scheduled work.
 5.Task.checkCancellation(): Throws a CancellationError if the task is canceled. This lets the function use the error-handling infrastructure to yield execution.
 6.Task.sleep(for:): Makes the task suspend for at least the given duration and doesn’t block the thread while that happens.
 7.Task.currentPriority: Returns the current task’s priority.
 8.Task.cancel(): Attempts to cancel the task and its child tasks.
 9.Task.yield(): Suspends the execution of the current task, giving the system a chance to cancel it automatically to execute some other task with higher priority.
 
 ** when your code creates a Task from the main thread, that task will run on the main thread, too. Therefore, you know you can update the app’s UI safely.
 */

struct Tasks {
    static func fetchData() async -> String {
        try! await Task.sleep(for: .seconds(2))
        return "Data fetched"
    }
    //1. Task(priority:operation)
    /*
     the performTask's Task does not block the thread, this example can not get the result in fetchData()
     */
    static func performTask() {
        Task {
            let result = await fetchData()
            print("Result: \(result)")
        }
    }
    
    //2. Task.detached(priority:operation)
    static func performDetachedTask() {
        Task.detached(priority: .medium) {
            let result = await fetchData()
        }
    }
    
    //3.Task.value
    static func getTaskValue() async {
        let task = Task {
            await fetchData()
        }
        
        let result = await task.value
    }
    
    //4.Task.isCancelled
    static func TaskIsCancelled() async{
        let task = Task {
            await fetchData()
        }
        
        task.cancel()
        
        // This will handle the task completion, including cancellation
        let result = await task.value
    }
    
    //5.Task.checkCancellation()
    static func TaskCheckCancellation() async throws{
        try Task.checkCancellation()
    }
    
    //6. Task.sleep
    /*
     Swift's Task.sleep() method automatically checks for cancellation, meaning that if you cancel a sleeping task it will be woken and throw a CancellationError for you to catch.
     */
    func listPhotos(inGallery name: String) async throws -> [String] {
        try await Task.sleep(for: .seconds(2))
        //try await Task.sleep(for: .seconds(3), tolerance: .seconds(1))
        return ["IMG001", "IMG99", "IMG0404"]
    }
    
    //9. insert suspension point
    /*
     Assuming the code that renders video is synchronous, it doesn’t contain any suspension points. The work to render video could also take a long time. However, you can periodically call Task.yield() to explicitly add suspension points. Structuring long-running code this way lets Swift balance between making progress on this task, and letting other tasks in your program make progress on their work.
     */
    func generateSlideshow(forGallery gallery: String) async throws{
        let photos = try await listPhotos(inGallery: gallery)
        for photo in photos {
            // ... render a few seconds of video for this photo ...
            await Task.yield()
        }
    }
}
