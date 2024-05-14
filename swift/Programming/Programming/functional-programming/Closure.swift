//
//  Closure.swift
//  Programming
//
//  Created by ke on 2024/5/14.
//

import Foundation

class Closure {
    func closureExample() {
        let greet: (String) -> String = { name in
            return "Hello, \(name)!"
        }

        // Call the closure and assign its return value to a variable
        let greeting = greet("John")

        // Print the greeting
        print(greeting)
    }
}
