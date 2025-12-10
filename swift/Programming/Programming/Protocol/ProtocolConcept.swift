//
//  ProtocolConcept.swift
//  Programming
//
//  Created by ke Liu on 12/10/25.
//

//1. Protocol Constraint (Generic Constraint)
//static dispatch, compile time
func draw<T: Drawable>(_ value: T) {
    
}


//2. Existential Type (Protocol as a Runtime Box)
//dynamic dispatch, runtime, the compiler don't know the type when compile
func drawContext() {
    var _: any Drawable = Circle()
}



//3. Opaque type
//static dispatch, compile time, compiler know the type, but the caller only know the protocol Drawable
func drawItem() -> some Drawable {
    return Circle()
}

