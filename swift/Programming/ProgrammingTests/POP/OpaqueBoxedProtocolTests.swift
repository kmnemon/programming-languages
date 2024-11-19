//
//  OpaqueBoxedProtocolTests.swift
//  ProgrammingTests
//
//  Created by ke on 2024/9/10.
//

import Testing

struct OpaqueBoxedProtocolTests {
    init() async throws {
        
    }
    

    @Test func testBoxedProtocol() {
        var b = BoxedProtocol()
        b.run()
    }
}
