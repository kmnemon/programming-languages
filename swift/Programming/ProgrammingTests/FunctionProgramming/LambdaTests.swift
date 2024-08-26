//
//  LambdaTests.swift
//  Programming
//
//  Created by ke on 2024/5/25.
//

import XCTest

struct AAA {
    func aa() -> Void {
      print("~~~~aa func~~~~")
    }
}

final class LambdaTests: XCTestCase {
    func testMap() {
        var a: AAA?
        a?.aa()
        print("~~~~what~~~~")
        
//        sortFunction()
    }
}
