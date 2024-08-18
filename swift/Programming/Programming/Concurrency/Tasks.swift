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

class Tasks {
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
}
