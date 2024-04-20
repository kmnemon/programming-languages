//
//  interfaces.swift
//  swift
//
//  Created by ke on 3/25/24.
//

import Foundation

//1.require property name and type
protocol SomeProperty {
    var settable: Int { get set }
    static var readable: Int { get }
}

class SomePropertyClass: SomeProperty {
    var settable: Int
    static let readable: Int = 10
    
    init(settable: Int) {
        self.settable = settable
    }
}


//2.method protocol
protocol SomeMethod {
    func someMethod() -> String
    static func someStaticMethod()
}

protocol SomeMutatingMethod{
    mutating func someMutatingMethod()
}

struct SomeMethodClass: SomeMethod, SomeMutatingMethod {
    var a: Int
    
    func someMethod() -> String {
        return "hello"
    }
    
    static func someStaticMethod() {
    }
    
    mutating func someMutatingMethod() {
        a = 20
    }
}

//3.class-only protocol
protocol ClassOnlyProtocl: AnyObject {
    
}
