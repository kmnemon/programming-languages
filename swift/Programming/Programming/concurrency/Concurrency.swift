//
//  concurrency.swift
//  Programming
//
//  Created by ke on 2024/4/21.
//

import Foundation

//1. async await
func listPhotos(inGallery name: String) async -> [String] {
    let result = [""]// ... some asynchronous networking code ...
    return result
}

func showPhotos() async {
    let photoNames = await listPhotos(inGallery: "Summer Vacation")
}

//2. insert suspension point
/*
 Assuming the code that renders video is synchronous, it doesn’t contain any suspension points. The work to render video could also take a long time. However, you can periodically call Task.yield() to explicitly add suspension points. Structuring long-running code this way lets Swift balance between making progress on this task, and letting other tasks in your program make progress on their work.
 */
func generateSlideshow(forGallery gallery: String) async {
    let photos = await listPhotos(inGallery: gallery)
    for photo in photos {
        // ... render a few seconds of video for this photo ...
        await Task.yield()
    }
}

//3. Task.sleep
func listPhotos2(inGallery name: String) async throws -> [String] {
    try await Task.sleep(for: .seconds(2))
    return ["IMG001", "IMG99", "IMG0404"]
}

func showPhoto2() async {
    do {
        let photos = try await listPhotos2(inGallery: "A Rainy Weekend")
    } catch {
        print("Unexpected error: \(error).")
    }
}

//4.asynchronous sequence
func asynchronousSequence() async{
    let handle = FileHandle.standardInput
    do {
        for try await line in handle.bytes.lines {
            print(line)
        }
    } catch {
        print(error)
    }
}

//5.call asynchronous in parallel
func callAsynchronousInParallel() async {
    async let firstPhoto = downloadPhoto(named: "photoNames[0]")
    async let secondPhoto = downloadPhoto(named: "photoNames[1]")
    async let thirdPhoto = downloadPhoto(named: "photoNames[2]")


    let photos = await [firstPhoto, secondPhoto, thirdPhoto]
//    show(photos)
}

func downloadPhoto(named: String) async -> String {
    return ""
}


//6.Tasks and Task Groups
func tasks() {
    
}
