//
//  TimerExample.swift
//  Programming
//
//  Created by ke on 2025/1/7.
//

import Foundation
import Combine

class TimerExample {
    var duration = ""
    var timerTask: Task<Void, Error>?
    
    var downloadTask: Task<Void, Error>? {
        didSet {
            timerTask?.cancel()
            let startTime = Date().timeIntervalSince1970
            
            let timerSequence = Timer
                .publish(every: 1, tolerance: 1, on: .main, in: .common)
                .autoconnect()
                .map { date -> String in
                    let duration = Int(date.timeIntervalSince1970 - startTime)
                    return "\(duration)s"
                }
                .values
            
            timerTask = Task {
                for await duration in timerSequence {
                    self.duration = duration
                }
            }
        }
    }
    
}
