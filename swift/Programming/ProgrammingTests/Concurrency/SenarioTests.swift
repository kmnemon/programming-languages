//
//  SenarioTests.swift
//  Programming
//
//  Created by ke on 1/1/25.
//
import Testing


@Test func testConcurrentExample() async {
    let r = await concurrentExample()
    #expect(r == 10)
}

@Test func testParallelExample() async {
    let r = await parallelExample1()
    #expect(r == 35)
}

@Test func testConcurrentWithParallelExample() async {
    let r = await concurrentWithParallelExample()
    #expect(r == 70)
}

