//
//  ActorIsolateFunc.swift
//  Programming
//
//  Created by ke on 2025/1/16.
//

import Foundation
actor DataStore {
    var username = "Anonymous"
    var friends = [String]()
    var highScores = [Int]()
    var favorites = Set<Int>()

    init() {
        // load data here
    }

    func save() {
        // save data here
    }
}

func debugLog(dataStore: isolated DataStore) {
    print("Username: \(dataStore.username)")
    print("Friends: \(dataStore.friends)")
    print("High scores: \(dataStore.highScores)")
    print("Favorites: \(dataStore.favorites)")
}


func applyActorIsolatedFunction() async {
    let data = DataStore()
    await debugLog(dataStore: data)
}
