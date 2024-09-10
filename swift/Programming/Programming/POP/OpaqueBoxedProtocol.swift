//
//  OpaqueBoxedProtocol.swift
//  Programming
//
//  Created by ke on 2024/9/10.
//

import Foundation
/*
 1. opaque type
 A function or method that returns an opaque type hides its return value’s type information. Instead of providing a concrete type as the function’s return type, the return value is described in terms of the protocols it supports. Opaque types preserve type identity — the compiler has access to the type information, but clients of the module don’t.

 2. boxed protocal type
 A boxed protocol type can store an instance of any type that conforms to the given protocol. Boxed protocol types don’t preserve type identity — the value’s specific type isn’t known until runtime, and it can change over time as different values are stored.
 */

class OpaqueReturnType {
    
}

class BoxedProtocol {
    protocol Drawable {
        func draw()
    }
    
    struct Circle: Drawable {
        func draw() {
            print("Drawing a circle")
        }
    }
    
    struct Square: Drawable {
        func draw() {
            print("Drawing a square")
        }
    }
    
    func run() {
        let drawables: [any Drawable] = [Circle(), Square()]

        for drawable in drawables {
            drawable.draw()
        }
        
        if let downcast = drawables[0] as? Circle {
            print(downcast)
        }
    }
    
}

