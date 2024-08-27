//
//  Actor.swift
//  Programming
//
//  Created by ke on 2024/8/20.
//

import Foundation

struct Work: Sendable {}

actor Worker {
    var work: Task<Void, Never>?
    var result: Work?


    deinit {
        // even though the task is still retained,
        // once it completes it no longer causes a reference cycle with the actor


        print("deinit actor")
    }


    func start() {
        work = Task {
            print("start task work")
            try? await Task.sleep(for: .seconds(3))
            self.result = Work() // we captured self
            print("completed task work")
            // but as the task completes, this reference is released
        }
        // we keep a strong reference to the task
    }
}


//await Worker().start()
