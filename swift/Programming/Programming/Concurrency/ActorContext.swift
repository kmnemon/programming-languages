//
//  ActorContext.swift
//  Programming
//
//  Created by ke on 2025/1/14.
//

import Foundation

/*
 The actor context part is more important and more complex. When you create a regular task from inside an actor it will be isolated to that actor, which means you can use other parts of the actor synchronously
 */

actor User5 {
    func authenticate(user: String, password: String) -> Bool {
        // Complicated logic here
        return true
    }

    func login() {
        Task {
            if authenticate(user: "taytay89", password: "n3wy0rk") {
                print("Successfully logged in.")
            } else {
                print("Sorry, something went wrong.")
            }
        }
    }
}

func applyUserActor() async {
    let user = User5()
    await user.login()
    
    try? await Task.sleep(for: .seconds(0.5))
}
