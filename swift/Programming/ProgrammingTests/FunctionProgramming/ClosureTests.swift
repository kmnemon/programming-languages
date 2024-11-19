//
//  File.swift
//  ProgrammingTests
//
//  Created by ke on 2024/8/26.
//

import Testing


struct ClosureTests {
    @Test func testTrailingClosure() {
        closureInFunctionParameter { item in
            print(item)
        }
    }
}
