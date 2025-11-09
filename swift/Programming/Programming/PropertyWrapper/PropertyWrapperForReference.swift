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

/*
 ****Explain:****

//@Box3 var person = Person3(name: "Chris")
//the compiler synthesize the _person for actual storage

private var _person = Box3(wrappedValue: Person3(name: "Chris"))
var person: Person3 {
    get { _person.wrappedValue }
    set { _person.wrappedValue = newValue }
}
 
 1.
 symbol:@Box3 var person
 type:Person3
 meaning:The user-facing property you access normally,
 Computed getter/setter delegating to _person.wrappedValue
 
 2.
 symbol:_person
 type:Box3<Person3>
 meaning:The synthesized storage property created by the compiler,
 Actual storage for the wrapped value
 
 3.
 symbol:$person
 type:Reference<Person3>
 meaning:The projected value, coming from _person.projectedValue
 A computed property derived from _person (not stored separately)
*/
