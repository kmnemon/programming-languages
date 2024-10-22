//
//  foreach.swift
//  swift
//
//  Created by ke on 4/18/24.
//

import Foundation

class Loop {
    func loopNumber() {
        for i in 1...10 {
            print(i)
        }
    }
    
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
    
    enum WeatherType {
        case Cloudy
        case Sunny
        case Windy
    }
    
    func loopEnum() {
        let forecast: [WeatherType] = [.Cloudy, .Sunny]
        
        for day in forecast where day == .Cloudy {
            print(day)
        }
    }
    
    enum WeatherType1 {
        case Cloudy(coverage: Int)
        case Sunny
        case Windy
    }
    
    func loopEnum2() {
        let forecast: [WeatherType1] = [.Cloudy(coverage: 40), .Sunny, .Windy, .Cloudy(coverage: 100), .Sunny]
        
        for case let .Cloudy(coverage) in forecast {
            print("It's cloudy with \(coverage)% coverage")
        }
        
        for case .Cloudy(40) in forecast {
            print("It's cloudy with 40% coverage")
        }

    }

    func loopWhere() {
        let numbers: [Int] = [1,2,5,4]
        for number in numbers where number % 2 == 1 {
            print(number)
        }
        
        let celebrities = ["Michael Jackson", "Taylor Swift", "Michael Caine", "Adele Adkins", "Michael Jordan"]
        for name in celebrities where !name.hasPrefix("Michael") {
            print(name)
        }
        
        for name in celebrities where name.hasPrefix("Michael") && name.count == 13 {
            print(name)
        }
        
        
        let celebrities2: [String?] = ["Michael Jackson", nil, "Michael Caine", nil, "Michael Jordan"]
        for case let name? in celebrities {
            print(name)
        }
    }
    
    static func loopStride() {
        for i in stride(from: 0, to: 1, by: 0.1) {
            print(i)
        }
    }
        
    
}
