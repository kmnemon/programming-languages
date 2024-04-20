//
//  foreach.swift
//  swift
//
//  Created by ke on 4/18/24.
//

import Foundation

class Loop {
    let games = ["Mahjong", "Gomoku Narabe Ren", "Popeye no Eigo Asobi"]
    
    func loop1(){
        for game in games {
            print(game)
        }
    }
    
    func loop2(){
        for case "Mahjong" in games {
            print("Mah")
        }
    }
    
    func loop3(){
        let array: [Any?] = ["abc", 18, nil, "ddd"]
        
        for case let .some(data) in array{
            print(data)
        }
        
        for case let data? in array{
            print(data)
        }
    }
    
    
    
}
