//
//  Tasks.swift
//  Programming
//
//  Created by ke on 2024/8/17.
//

import Foundation
/*
 • Task(priority:operation): Schedules operation for asynchronous execution with the given priority. It inherits defaults from the current synchronous context.
 • Task.detached(priority:operation): Similar to Task(priority:operation), except that it doesn’t inherit the defaults of the calling context.
 • Task.value: Waits for the task to complete, then returns its value, similarly to a promise in other languages.
 • Task.isCancelled: Returns true if the task was canceled since the last suspension point. You can inspect this boolean to know when you should stop the execution of scheduled work.
 • Task.checkCancellation(): Throws a CancellationError if the task is canceled. This lets the function use the error-handling infrastructure to yield execution.
 • Task.sleep(for:): Makes the task suspend for at least the given duration and doesn’t block the thread while that happens.
 */

/* Task Cancel
 Task.isCancelled: Returns true if the task is still alive but has been canceled since the last suspension point.
 • Task.currentPriority: Returns the current task’s priority.
 • Task.cancel(): Attempts to cancel the task and its child tasks.
 • Task.checkCancellation(): Throws a CancellationError if the task is canceled, making it easier to exit a throwing context.
 • Task.yield(): Suspends the execution of the current task, giving the system a chance to cancel it automatically to execute some other task with higher priority.
 
 */

struct Tasks {
    //1. Task.sleep
    func listPhotos(inGallery name: String) async throws -> [String] {
        try await Task.sleep(for: .seconds(2))
        return ["IMG001", "IMG99", "IMG0404"]
    }
    
    func showPhoto2() async {
        do {
            let photos = try await listPhotos(inGallery: "A Rainy Weekend")
        } catch {
            print("Unexpected error: \(error).")
        }
    }
    
    //2. insert suspension point
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
