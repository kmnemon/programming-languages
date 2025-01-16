//
//  MainActor.swift
//  Programming
//
//  Created by ke on 1/7/25.
//

import Foundation

/*
 1. MainActor.run
 is used to execute a block of code on the main thread. This is particularly useful when you need to update the UI from a background thread, as UI updates must always occur on the main thread.
*/
class MainActorExample {
    var message: String = ""
    
    func updateMessage() {
        // Simulate a background task
        DispatchQueue.global(qos: .background).async {
            // Simulating a delay for background work
            sleep(2)
            
            // Use MainActor to ensure the UI update happens on the main thread
            Task {
                await MainActor.run {
                    self.message = "Message updated from background!"
                }
            }
        }
    }
}


/*
 2. MainActor class
 for model classes that drive your UI, you might as well assign all your model code to run on the main actor.
*/
@MainActor
class LongLiveViewModel2 {
//    var stock: Stock = Stock(name: "default", value: 1.0)

    private var liveURLSession: URLSession = {
      var configuration = URLSessionConfiguration.default
      configuration.timeoutIntervalForRequest = .infinity
      return URLSession(configuration: configuration)
    }()
    
    func availableStocks() async throws {
        guard let url = URL(string: "http://localhost:8080/stock-stream")
        else {
            throw "The URL could not be created"
        }
        
//        let (stream, response) = try await liveURLSession.bytes(from: url)
//        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
//          throw "The server responded with an error."
//        }
//        
//        for try await line in stream.lines {
//            self.stock = try JSONDecoder()
//            .decode(Stock.self, from: Data(line.utf8))
//            print("Updated: \(Date())")
//        }
    }
}


//3. If you wanted the work to be sent off to the main actor without waiting for its result to come back, you can place it in a new task like this
func couldBeAnywhere() {
    Task {
        await MainActor.run {
            print("This is on the main actor.")
        }
    }

    // more work you want to do
}

//4.you can also mark your task’s closure as being @MainActor
/*
 This is particularly helpful when you’re inside a synchronous context, so you need to push work to the main actor without using the await keyword.
 */
func couldBeAnywhere2() {
    Task { @MainActor in
        print("This is on the main actor.")
    }

    // more work you want to do
}


//5.which one run first
//1,2,4,5,3
@MainActor @Observable
class ViewModel {
    func runTest() async {
        print("1")

        await MainActor.run {
            print("2")

            Task { @MainActor in
                print("3")
            }

            print("4")
        }

        print("5")
    }
}

//let model = ViewModel()
//await model.runTest()
//try await Task.sleep(for: .seconds(0.1))
