//
//  ActorNonisolated.swift
//  Programming
//
//  Created by ke on 2025/1/16.
//

import CryptoKit
import Foundation

actor UserNonisolated {
    let username: String
    let password: String
    var isOnline = false

    init(username: String, password: String) {
        self.username = username
        self.password = password
    }

    nonisolated func passwordHash() -> String {
        let passwordData = Data(password.utf8)
        let hash = SHA256.hash(data: passwordData)
        return hash.compactMap { String(format: "%02x", $0) }.joined()
    }
}

func applyNonisolatedFunc() {
    let user = UserNonisolated(username: "twostraws", password: "s3kr1t")
    print(user.passwordHash())
}
