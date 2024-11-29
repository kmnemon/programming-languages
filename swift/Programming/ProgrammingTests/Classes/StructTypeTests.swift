//
//  StructTypeTests.swift
//  Programming
//
//  Created by ke on 2024/5/14.
//

import Testing

struct Counter {
    var value: Int
    var setValue: (Int) -> ()
    
    func what(value: Int) {
        setValue(value + 1)
    }
}

struct StructTypeTests {
    @Test func testNestedStruct() {
        let a: StructTypeA = StructTypeA()
        print(a.a ?? 10)
        
        let b: StructTypeA.StructTypeB = StructTypeA.StructTypeB()
        print(b.b ?? 20)
    }
    
    @Test func testCopyMeaning() {
        var c = CopyMeaning(a: 2)
        canInOutHasReferenceMeaning(copyOne: &c)
        print(c.a)
    }
    
    @Test func testStruct() {
        var a = 0
        
        let c = Counter(value: a, setValue: {a = $0})
        
        c.what(value: 10)
        print("reslut is\(a)")
        
        print("reslut is\(c.value)\n")
        
        
        
        
    }
}





