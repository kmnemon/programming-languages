//
//  StructType.swift
//  Programming
//
//  Created by ke on 2024/5/14.
//

import Foundation

//1.struct
struct StructTypeA {
    var a: Int?
    struct StructTypeB {
        var b: Int?
    }
}

//2.cpoy meaning
struct CopyMeaning {
    var a: Int
}

func canInOutHasReferenceMeaning(copyOne: inout CopyMeaning) {
}

//3.boxing
struct Person {
    var name: String
    var age: Int
    var favoriteIceCream: String
}
let taylor = Person(name: "Taylor Swift", age: 26, favoriteIceCream: "Chocolate")

final class PersonBox {
    var person: Person
    init(person: Person) {
        self.person = person
    }
}

let box = PersonBox(person: taylor)

final class TestContainer {
    var box: PersonBox! //implicitly unwrapped optional
}

func testContainer() {
    let container1 = TestContainer()
    let container2 = TestContainer()
    container1.box = box
    container2.box = box
    
    print(container1.box.person.name)
    print(container2.box.person.name)
    
    box.person.name = "Not Taylor"
    
    print(container1.box.person.name)
    print(container2.box.person.name)
}


final class Box<T> {
    var value: T
    init(value: T) {
        self.value = value
    }
}
