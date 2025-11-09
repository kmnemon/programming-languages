//
//  PropertyWrapperForFunction.swift
//  Programming
//
//  Created by ke Liu on 11/9/25.
//

//1.
func takesBox(@Box2 foo: String) {
    
}

//the compiler rewrite the code
func takesBoxRewrite(foo initialValue: String) {
    var _foo: Box2<String> = Box2(wrappedValue: initialValue)
    var foo: String {
        get { _foo.wrappedValue }
        set { _foo.wrappedValue = newValue }
    }
}

//2. However, if the property wrapper has an initializer named init(projectedValue:), the compiler will also generate a different version of the function that takes a projectedValue.For example, if we implemented init(projectedValue:) on Box, the second version of the takesBox function would look like this:
/*
func takesBox($foo initialValue: Reference<String>) {
    var _foo: Box<String> = Box(projectedValue: initialValue)
    var foo: String {
        get { _foo.wrappedvalue }
        nonmutating set { foo.wrappedValue = newValue }
    }
}
*/
