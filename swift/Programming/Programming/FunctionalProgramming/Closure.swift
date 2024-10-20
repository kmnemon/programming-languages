//
//  Closure.swift
//  Programming
//
//  Created by ke on 2024/5/14.
//

import Foundation

//1.closure
class Closure {
    // #example 1
    func closureExample1() {
        let greet = {
            print("hellow")
        }
        
        
    }
    
    func runSomeClosure(closure: () -> Void) {
        closure()
    }
    //runSomeClosure(greetPerson)
    
    //# example2
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
        
        print(greeting)
    }
    
    //# example3: trailing closure
    func closureExample3(closure: (String) -> String) {
        print(closure("John"))
    }
    
    func callTheFunctionWithTrailingClosure() {
        closureExample3 { name in
            return "Hello, \(name)!"
        }
    }
    
}

//2. escaping ,nonescaping and auto closure
class escapeAndNonEscapeAndAutoClosure {
    /*
     A closure that is called after the function it was supplied to returns is referred to as an escaping closure. It outlives the function it was supplied to, in other words. The completion handler is an illustration of an escaping closure. A completion handler is often run in the future, depending on how it is implemented. When a task takes a long time to finish, the closure escapes and outlives the purpose for which it was designed. An escaping closure can be thought of as code that outlives the function it was provided into. Imagine that function as a prison, and the closure as a bandit breaking out of the prison.
     */
    func escapingClosure() {
        let url = URL(string: "https://www.geeksforgeeks.org/")!
        let data = try? Data(contentsOf: url)
        
        // Function to call the escaping closure
        func loadData(completion: @escaping (_ data: Data?) -> Void) {
            DispatchQueue.global().async
            {
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async
                {
                    completion(data)
                }
            }
        }
        
        // use data
        loadData { data in
            guard data != nil else {
                
                // Handle error
                return
            }
        }
        
        // Print result
        print("Data loaded")
    }
    /*
     A closure that is called inside the function it was supplied into, that is, before it returns, is referred to as a non-escaping closure. This closure never exceeds the function it was supplied into boundaries. The function, when given a closure as a parameter, executes the closure and returns the compiler. The passed closure in this case no longer exists in memory once the closure has been executed and execution has concluded since it has left the scope. During the course of their lifetime, non-escaping closures change into different states.
     */
    func nonEscapingClosure() {
        func doWork(completion: () -> Void)
        {
            
            // Perform some work
            completion()
        }
        
        // Print result
        doWork
        {
            print("Work is complete")
        }
    }
    /*
     An autoclosure is a closure that is automatically created to wrap a piece of code. It is a way to delay the execution of closure until it is actually needed. Autoclosures are often used as arguments to functions where the closure is optional or where the closure’s execution may not always be necessary.
     */
    func autoClosure() {
        func logIfTrue(_ condition: @autoclosure () -> Bool)
        {
            if condition()
            {
                print("True")
            }
            else
            {
                print("False")
            }
        }
        
        logIfTrue(2 > 1)
    }
}

//3. closure in function parameter
func closureInFunctionParameter(fn: (Int) -> Void) {
    var i = 5
    fn(i)
}

//4. capture lists in closure
func captureListsInClosure() {
    var index = 0
    let closure = { [index] in
        print(index)
    }
    index = 1
    Closure() // this will print "0", not "1"
}




