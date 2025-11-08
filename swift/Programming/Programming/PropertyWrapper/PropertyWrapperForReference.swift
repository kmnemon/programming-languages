//
//  PropertyWrapperForReference.swift
//  Programming
//
//  Created by ke Liu on 11/8/25.
//

//2. like SwiftUI @Binding, using projected value

@propertyWrapper
class Box3<A> {
    var wrappedValue: A
    
    var projectedValue: Reference<A> {
        Reference<A>(get: { self.wrappedValue }, set: { self.wrappedValue = $0 })
    }
    
    init(wrappedValue: A) {
        self.wrappedValue = wrappedValue
    }
    
    //This allows us to create a Reference<String> by writing $person.name
    subscript<B>(dynamicMember keyPath: WritableKeyPath<A, B>) -> Reference<B> {
        Reference<B>(get: {
            self.wrappedValue[keyPath: keyPath]
        }) {
            self.wrappedValue[keyPath: keyPath] = $0
        }
    }
}


@propertyWrapper
class Reference<A> {
    private var _get: () -> A
    private var _set: (A) -> ()
    
    var wrappedValue: A {
        get { _get() }
        set { _set(newValue) }
    }
    
    init(get: @escaping () -> A, set: @escaping (A) -> ()) {
        _get = get
        _set = set
    }
}

struct Person3 {
    var name: String
}

struct Persion3Editor {
    @Reference var person: Person3
    
}


//class PersonManager {
//    @Box3 var person = Person3(name: "ke")
//
//    func makeEditor() -> Persion3Editor {
//        Persion3Editor(person: $person)
//    }
//}


func makeEditor() -> Persion3Editor {
    @Box3 var person = Person3(name: "Chris")
    return Persion3Editor(person: $person)
}
