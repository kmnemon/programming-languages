//
//  LambdaTests.swift
//  Programming
//
//  Created by ke on 2024/5/25.
//

import Testing

struct AAA {
    @Test func aa() -> Void {
      print("~~~~aa func~~~~")
    }
}

struct LambdaTests {
    @Test func testMap() {
        var a: AAA?
        a?.aa()
        print("~~~~what~~~~")
        
//        sortFunction()
    }
}
