//
//  memory-management.swift
//  swift
//
//  Created by ke on 3/24/24.
//

import Foundation

//1.using ARC
class A {
    
}

func usingARC() {
    var ref1: A? = A()
    var ref2: A? = ref1

    ref1 = nil
    ref2 = nil
}
