//
//  ClassGeneric.swift
//  Programming
//
//  Created by ke on 2024/5/20.
//

import Foundation

//1.generic type
struct deque<T>{
    var array = [T]()
    
    mutating func pushBack(obj: T) {
        array.append(obj)
    }
}
