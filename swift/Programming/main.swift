//
//  main.swift
//  Programming
//
//  Created by ke on 2024/4/20.
//

import Foundation


func fn() async {
    for i in 5...100 {
        print(i)
    }
  
}

func fn1() async {
    for i in 0...4 {
        print(i)
    }
}

Task {
    await fn()
}

Task {
    await fn1()
}

print("Hello, World!")


RunLoop.main.run()
