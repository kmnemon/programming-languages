//
//  PropertyWrappers.swift
//  Programming
//
//  Created by ke on 2024/11/6.
//

@propertyWrapper
struct NonNegative<Value: BinaryInteger> {
    var value: Value

    init(wrappedValue: Value) {
        if wrappedValue < 0 {
            value = 0
        } else {
            value = wrappedValue
        }
    }

    var wrappedValue: Value {
        get { value }
        set {
            if newValue < 0 {
                value = 0
            } else {
                value = newValue
            }
        }
    }
}

extension NonNegative{
    //Usage
    struct User {
        @NonNegative var score = 0
    }
}
