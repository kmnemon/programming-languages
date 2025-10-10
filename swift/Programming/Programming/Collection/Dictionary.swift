//
//  Dictionary.swift
//  Programming
//
//  Created by ke Liu on 10/10/25.
//

//1. frequency
extension Sequence where Element: Hashable {
    var frequencies: [Element:Int] {
        let frequencyPairs = self.map { ($0, 1) }
        return Dictionary(frequencyPairs, uniquingKeysWith: +)
    }
}

func frequenciesExample() {
    let frequencies = "hello" //["h": 1, "l": 2, "e": 1, "o": 1]
}

//2. disctionary value to string
enum Setting {
    case text(String)
    case ini(Int)
    case bool(Bool)
}


func dictionaryValueToString() {
    let settings:[String: Setting] = [
        "Airplan Mode": .bool(false),
        "Name": .text("My iPhone")
    ]
    
    let settingsAsStrings = settings.mapValues { setting -> String in
        switch setting {
        case .text(let text): return text
        case .ini(let number): return String(number)
        case .bool(let value): return String(value)
        }
    }
}


