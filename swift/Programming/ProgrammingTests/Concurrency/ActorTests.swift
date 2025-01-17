//
//  ActorTests.swift
//  Programming
//
//  Created by ke on 1/17/25.
//

import Testing

@Test func TestAcotr22() async {
    let p = Player2()
    await withKnownIssue("what") {
        try await p.addTo()
    }
   
}
