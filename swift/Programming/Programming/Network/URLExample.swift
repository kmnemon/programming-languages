//
//  URLExample.swift
//  Programming
//
//  Created by ke on 2025/1/10.
//

import Foundation

//1. url.lines
func fetchUsers() async throws {
    let url = URL(string: "https://hws.dev/users.csv")!

    for try await line in url.lines {
        print("Received user: \(line)")
    }
}

func getUrlLines() async {
    try? await fetchUsers()
}
