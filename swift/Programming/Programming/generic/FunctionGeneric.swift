//
//  FunctionGeneric.swift
//  Programming
//
//  Created by ke on 2024/5/20.
//

import Foundation

func inspect<T>(value: T) {
    print("Received \(value.dynamicType) with the value \(value)")
}
