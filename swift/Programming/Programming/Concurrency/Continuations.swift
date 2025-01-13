//
//  Untitled.swift
//  Programming
//
//  Created by ke on 1/14/25.
//

import Foundation
/*
 These two code samples are fairly similar, which shows how important it is to be careful with your continuations. However, if you have checked your code carefully and you’re sure it is correct, you can if you want replace the withCheckedContinuation() function with a call to withUnsafeContinuation(), which works exactly the same way but doesn’t add the runtime cost of checking you’ve used the continuation correctly.

 Note: If you want a continuation that sends back nothing, you can just use continuation.resume() with no parameters.
 */

struct Continuations {
    //old iOS code without async/await
    struct Message: Decodable, Identifiable {
        let id: Int
        let from: String
        let message: String
    }

    func fetchMessages(completion: @Sendable @escaping ([Message]) -> Void) {
        let url = URL(string: "https://hws.dev/user-messages.json")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data {
                if let messages = try? JSONDecoder().decode([Message].self, from: data) {
                    completion(messages)
                    return
                }
            }

            completion([])
        }.resume()
    }
    
    func fetchMessages() async -> [Message] {
        await withCheckedContinuation { continuation in
            fetchMessages { messages in
                continuation.resume(returning: messages)
            }
        }
    }
    
    func apply() async {
        let messages = await fetchMessages()
        print("Downloaded \(messages.count) messages.")
    }
}

/*
 Tip: Using withUnsafeThrowingContinuation() comes with all the same warnings as using withUnsafeContinuation() – you should only switch over to it if it’s causing a performance problem.
 */

struct ContinuationsWithError {
    struct Message: Decodable, Identifiable {
        let id: Int
        let from: String
        let message: String
    }

    func fetchMessages(completion: @Sendable @escaping ([Message]) -> Void) {
        let url = URL(string: "https://hws.dev/user-messages.json")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let messages = try? JSONDecoder().decode([Message].self, from: data) {
                    completion(messages)
                    return
                }
            }

            completion([])
        }.resume()
    }

    // An example error we can throw
    enum FetchError: Error {
        case noMessages
    }

    func fetchMessages() async -> [Message] {
        do {
            return try await withCheckedThrowingContinuation { continuation in
                fetchMessages { messages in
                    if messages.isEmpty {
                        continuation.resume(throwing: FetchError.noMessages)
                    } else {
                        continuation.resume(returning: messages)
                    }
                }
            }
        } catch {
            return [
                Message(id: 1, from: "Tom", message: "Welcome to MySpace! I'm your new friend.")
            ]
        }
    }

    func apply() async {
        let messages = await fetchMessages()
        print("Downloaded \(messages.count) messages.")
    }
}

/*
 https://www.hackingwithswift.com/quick-start/concurrency/how-to-store-continuations-to-be-resumed-later
 So, rather than receiving the result of our work through a single completion closure, we instead get the result in two different places. In this situation we need to do a little more work to create async functions using continuations, because we need to be able to resume the continuation in either method.

 To solve this problem you need to know that continuations are just structs with a specific generic type. For example, a checked continuation that succeeds with a string and never throws an error has the type CheckedContinuation<String, Never>, and an unchecked continuation that returns an integer array and can throw errors has the type UnsafeContinuation<[Int], Error>.

 All this is important because to solve our delegate callback problem we need to stash away a continuation in one method – when we trigger some functionality – then resume it from different methods based on whether our code succeeds or fails.
 */
/*
@Observable
class LocationManager: NSObject, CLLocationManagerDelegate {
    var locationContinuation: CheckedContinuation<CLLocationCoordinate2D?, any Error>?
    let manager = CLLocationManager()

    override init() {
        super.init()
        manager.delegate = self
    }

    @MainActor
    func requestLocation() async throws -> CLLocationCoordinate2D? {
        try await withCheckedThrowingContinuation { continuation in
            locationContinuation = continuation
            manager.requestLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationContinuation?.resume(returning: locations.first?.coordinate)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        locationContinuation?.resume(throwing: error)
    }
}

struct ContentView: View {
    @State private var locationManager = LocationManager()

    var body: some View {
        LocationButton {
            Task {
                if let location = try? await locationManager.requestLocation() {
                    print("Location: \(location)")
                } else {
                    print("Location unknown.")
                }
            }
        }
        .frame(height: 44)
        .foregroundStyle(.white)
        .clipShape(.capsule)
        .padding()
    }
}
*/
