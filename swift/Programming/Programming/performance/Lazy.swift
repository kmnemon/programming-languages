//
//  Lazy.swift
//  Programming
//
//  Created by ke on 2024/5/14.
//

import Foundation

class X{
    init() {
        print("X init")
    }
}

class Lazy {
    lazy var l = "Hello \(X())"
}
