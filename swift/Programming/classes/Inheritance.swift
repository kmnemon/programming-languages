//
//  inheritance.swift
//  swift
//
//  Created by ke on 3/28/24.
//

import Foundation

//1. init order

//2.access superclass
class Base1 {
    var b1: Int

    init(b1: Int) {
        self.b1 = b1
    }
    
    var b2: Int {
        get { b1 * 3 }
        set { b1 = newValue / 3 }
    }
    
    subscript(index: Int) -> Int {
        return index * 6
    }
    
    func baseFunc() {
    }
}

class Derived1 : Base1 {
    var d1: Int
    
    init(d1: Int, b1: Int) {
        self.d1 = d1
        super.init(b1: b1)
    }
    
    //a.access superclass compute proterty
    override var b2: Int {
        get{ d1 * super.b2 * 4 }
        set{ d1 = newValue / super.b2 }
    }
    
    //b.access superclass subscript
    override subscript(index: Int) -> Int {
        return super[index] * 12
    }
    
    //c.access superclass method
    override func baseFunc() {
        super.baseFunc()
        //...
    }
}

//3.overriding property observers
class Base2 {
    var b2: Int = 1
    final func base2Func() {} //can not override
    
    var base2: Int {
        get { b2 * 2 }
        set { b2 = newValue * 3 }
    }
}

class Derived2 : Base2 {
    override var base2: Int {
        didSet {
            print("b2 is set")
        }
    }
}

//4. static vs class override
class Base3 {
    class func b() {
        print("Base3-b()")
    }
    
    static func b2() {
        
    }
}

class Derived3 : Base3 {
    override class func b() {
        print("Derived3-b()")
    }
    
    //not allowed to override static method in super class
//    override static func b2() {
//
//    }
}


