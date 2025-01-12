//
//  SendableExample.swift
//  Programming
//
//  Created by ke on 1/10/25.
//

import Foundation

//1. make class sendable
final class UserSendable: Decodable, Sendable {
    let name: String
    let password: String

    init(name: String, password: String) {
        self.name = name
        self.password = password
    }
}

func printUser(for user: UserSendable) async {
    print(user.name)
}


//2. @Sendable
func repeatAction(_ action: @escaping @Sendable () -> Void) {
    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
        action()
    }
}

actor Counter {
    var value = 0

    func increment() {
        value += 1
        print("Counter incremented: \(value)")
    }
}

//the Task is Sendable if its work is also Sendable.
func applyRepeatAction() {
    let counter = Counter()
    
    repeatAction {
        Task {
            // This is safe
            await counter.increment()
        }
    }
}
