//
//  Switch.swift
//  Programming
//
//  Created by ke on 2024/4/20.
//

import Foundation

struct Switch {
    func switchCase1() {
        let name = "ke"
        
        switch name {
        case "bob":
            print("bob")
        case "ke":
            print("ke")
        default:
            print("default")
        }
    }
    
    func switchCase2() {
        let pair = (game: "primer", platform: "nintendo")
        
        switch pair {
        case ("primer", "ps5"):
            print("ps5 primer")
        case ("primer", "nintendo"):
            print("nintendo primer")
        default:
            print("not match")
        }
    }
    
    func switchCase3() {
        let pair = (game: "primer", platform: "nintendo", online: "no")
        
        switch pair {
        case ("primer", "ps5", _):
            print("ps5 primer")
        case ("primer", "nintendo", _):
            print("nintendo primer")
        default:
            print("not match")
        }
    }
    
    func switchCase4() {
        let pair = (game: "primer", platform: "nintendo")
        
        switch pair {
        case ("primer", let platform):
            print("\(platform) primer")
        case ("primer", "nintendo"):
            print("nintendo primer")
        default:
            print("not match")
        }
    }
    
    func switchCase5() {
        switch (5%3 == 0) {
        case true:
            print("good")
        case false:
            print("wow")
        }
    }
    
    func switchCase6(){
        let name: String? = "twostraws"
        let password: String? = "fr0st1es"
        
        switch (name, password) {
        case let (.some(name), .some(password)):
            print("Hello, \(name) \(password)")
        case let (.some(name), .none):
            print("\(name) Please enter a password.")
        default:
            print("Who are you?")
        }
        
        switch (name, password) {
        case let (name?, password?):
            print("Hello, \(name) \(password)")
        case let (username?, nil):
            print("Please enter a password.")
        default:
            print("Who are you?")
        }
    }
    
    func switchCase7(){
        let age = 30
        
        switch age {
        case 0 ..< 10:
            print("")
        case 10 ..< 100:
            print("")
        default:
            print("")
        }
    }
    
}
