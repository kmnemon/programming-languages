//
//  OptionalWithString.swift
//  Programming
//
//  Created by ke on 10/23/25.
//


infix operator ???: NilCoalescingPrecedence

public func ???<T>(optional: T?, defaultValue: @autoclosure () -> String) -> String {
    switch optional {
        case let value?: return String(describing: value)
        case nil: return defaultValue()
    }
}

//“let bodyTemperature: Double? = 37.0”
//“print("Body temperature: \(bodyTemperature ??? "n/a")")”
