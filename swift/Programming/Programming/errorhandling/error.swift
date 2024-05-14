//
//  error.swift
//  Programming
//
//  Created by ke on 2024/5/14.
//

import Foundation

class Error {
    func giveAwardTo(name: String) {
        guard name == "Taylor Swift" else {
            print("No way!")
            return
        }
        print("Congratulations, \(name)!")
    }
    
    func giveAwardTo(name: String?) {
        guard let winner = name else {
            print("No one won the award")
            return
        }
        print("Congratulations, \(winner)!")
    }
    

    func divide() {
        for i in 1...100 {
            guard i % 8 == 0 else { continue }
            print(i)
        }
    }
}
