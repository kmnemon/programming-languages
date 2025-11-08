//
//  PropertyWrapper.swift
//  Programming
//
//  Created by ke Liu on 11/8/25.
//

//1.like SwiftUI @State, using wrapper value
@propertyWrapper
class Box2<A> {
    var wrappedValue: A
    
    init(wrappedValue: A) {
        self.wrappedValue = wrappedValue
    }
}

struct Checkbox {
    @Box2 var isOn: Bool = false
    
    func didTap() {
        isOn.toggle()
    }
}

//rewrite by the compiler
struct CheckboxTransformation {
    private var _isOn: Box2<Bool> = Box2(wrappedValue: false)
    var isOn: Bool {
        get { _isOn.wrappedValue }
        nonmutating set { _isOn.wrappedValue = newValue }
    }
    
    func didTap() {
        isOn.toggle()
    }
}
