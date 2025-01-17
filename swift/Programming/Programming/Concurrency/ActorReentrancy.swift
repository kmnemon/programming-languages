//
//  ActorReentrancy.swift
//  Programming
//
//  Created by ke on 2025/1/17.
//

import Foundation


actor Player {
    var name = "Anonymous"
    var score = 0
    
    func addToScore() {
        Task {
            score += 1
            try? await Task.sleep(for: .seconds(1))
            print("Score is now \(score)")
        }
    }
}

func ActorReentrancy() async {
    let player = Player()
    await player.addToScore()
    await player.addToScore()
    await player.addToScore()
    
    try? await Task.sleep(for: .seconds(1.1))
}

enum AAAA: Error {
    case aaa
}

class Player2 {
    func addTo() async throws {
        try? await Task.sleep(for: .seconds(0.1))
    }
    
}


