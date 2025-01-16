//
//  ActorExter.swift
//  Programming
//
//  Created by ke on 2025/1/16.
//
import Foundation

actor AuthenticationManager {
    var token: String?

    var isAuthenticated: Bool {
        token != nil
    }

    func authenticate(username: String, password: String) async throws {
        // Simulate authenticating a user.
        let url = URL(string: "https://hws.dev/authenticate")!
        let (data, _) = try await URLSession.shared.data(from: url)
        token = String(decoding: data, as: UTF8.self)
    }
}

func applyActor() async {
    let manager = AuthenticationManager()
    
    let first = Task {
        do {
            // Attempt to log in.
            try await manager.authenticate(username: "twostraws", password: "samoyed123")
            
            // Get the user's authentication token.
            if let token = await manager.token {
                print("User token: \(token)")
            }
        } catch {
            print("Authentication failed: \(error.localizedDescription)")
        }
    }
    
    let second = Task {
        // Attempt to access the authentication status elsewhere.
        let authenticated = await manager.isAuthenticated
        print("Second task check: \(authenticated)")
    }
    
    await first.value
    await second.value
}
