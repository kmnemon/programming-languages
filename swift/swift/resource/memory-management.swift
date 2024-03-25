//
//  memory-management.swift
//  swift
//
//  Created by ke on 3/24/24.
//

import Foundation

//1.using ARC
class ARC {
    
}

func usingARC() {
    var ref1: ARC? = ARC()
    var ref2: ARC? = ref1

    ref1 = nil
    ref2 = nil
}

//2.reference cycles problem
class A {
    var b: B?
}

class B {
    var a: A?
}

func rc(){
    var ca: A? = A()
    var cb: B? = B()
    ca!.b = cb
    cb!.a = ca
    
    ca = nil
    cb = nil
}

