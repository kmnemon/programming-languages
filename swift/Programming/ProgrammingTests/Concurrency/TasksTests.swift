//
//  TasksTests.swift
//  Programming
//
//  Created by ke on 1/1/25.
//

import Testing

struct TasksTests {
    @Test func testPerformTask() async throws{
        await Tasks.getTaskValue()
        print("finishd")
    }
}


