//
//  KeyPathWithFunction.swift
//  Programming
//
//  Created by ke on 11/10/25.
//


func keyPathWithFunc() {
    let simpsonResidence = Address(street: "1094 eve", city: "Springfield", zipCode: 97475)
    var jackson = Person4(name: "mj", address: simpsonResidence)
    var mia = Person4(name: "mia", address: simpsonResidence)
    let people = [jackson, mia]
    
    
    //1.The compiler can automatically convert a key-path expression to a function. For example, the following code is shorthand for people.map { $0.name }:
    
    //this only work for keyPath expression
    //With a key-path expression, the compiler has two options for the inferred type: \Person.name could either be KeyPath<Person, String> or (Person) -> String. The compiler will prefer the key path type, but if that doesn’t work, it’ll try the function type.
    print(people.map(\.name)) // ["mj", "mia"]
    
    
    //2. keyPath compose
    
    // KeyPath<Person, String> + KeyPath<String, Int> = KeyPath<Person, Int>
    let nameKeyPath = \Person4.name
    let nameCountKeyPath = nameKeyPath.appending(path: \.count)

}

