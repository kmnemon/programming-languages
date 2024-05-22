//
//  Closure.swift
//  Programming
//
//  Created by ke on 2024/5/14.
//

import Foundation

class Closure {
    func closureExample1() {
        let greet = {
            print("hellow")
        }
        

    }
    
    func runSomeClosure(closure: () -> Void) {
        closure()
    }
    //runSomeClosure(greetPerson)
    
    func closureExample2() {
        let greet: (String) -> String = { name in
            return "Hello, \(name)!"
        }
        
        let greet1 = { (name: String) in
            return "Hello, \(name)!"
        }
        
        var greetPerson = { [unowned self] (name: String)  in
            print("Hello, \(name)!")
        }

        // Call the closure and assign its return value to a variable
        let greeting = greet1("John")

        // Print the greeting
        print(greeting)
    }
}
