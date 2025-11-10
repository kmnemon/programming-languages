//
//  KeyPaths.swift
//  Programming
//
//  Created by ke Liu on 11/9/25.
//

struct Address {
    var street: String
    var city: String
    var zipCode: Int
}

struct Person4 {
    let name: String
    var address: Address
}

func keyPathExample() {
    //1. basic
    // WritableKeyPath<Person, String>, “WritableKeyPath. Because all properties that form this latter key path are mutable, the key path itself allows mutation of the underlying value"
    let streetKeyPath = \Person4.address.street
    // KayPath<Person, String>
    let nameKeyPath = \Person4.name
    
    let simpsonResidence = Address(street: "1094 eve", city: "Springfield", zipCode: 97475)
    var jackson = Person4(name: "mj", address: simpsonResidence)
    print(jackson[keyPath: nameKeyPath]) // mj
    
    //2. using in array
    var mia = Person4(name: "mia", address: simpsonResidence)
    let people = [jackson, mia]
    print(people[keyPath: \.[1].name])

   

}
