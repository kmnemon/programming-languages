//
//  File.swift
//  ProgrammingTests
//
//  Created by ke on 2024/8/26.
//

import XCTest


final class ClosureTests: XCTestCase {
    func testTrailingClosure() {
        closureInFunctionParameter { item in
            print(item)
        }
    }
}
