//
//  concurrency.swift
//  Programming
//
//  Created by ke on 2024/4/21.
//

import Foundation

extension String: Error { }

struct AsyncAwait {
    //1. async await
    static func availableSymbols() async throws -> [String] {
        guard let url = URL(string: "http://localhost:8080/littlejohn/symbols")
        else {
            throw "The URL could not be created."
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw "The server responded with an error."
        }
        return try JSONDecoder().decode([String].self, from: data)
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


//6.computed property asynchronous
var myPorperty: String {
    get async {
        return ""
    }
}

//    print(await myPorperty)

//7. closure asynchronous
func myFunction(work: (Int) async -> Int) {
    
}

