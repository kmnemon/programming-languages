//
//  StructTypeTests.swift
//  Programming
//
//  Created by ke on 2024/5/14.
//

import XCTest

final class StructTypeTests: XCTestCase {
    func testNestedStruct() {
        let a: StructTypeA = StructTypeA()
        print(a.a ?? 10)
        
        var b: StructTypeA.StructTypeB = StructTypeA.StructTypeB()
        print(b.b ?? 20)
    }
    
    func testCopyMeaning() {
        var c = CopyMeaning(a: 2)
        canInOutHasReferenceMeaning(copyOne: &c)
        print(c.a)
    }
}
