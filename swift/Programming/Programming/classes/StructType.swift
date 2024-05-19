//
//  StructType.swift
//  Programming
//
//  Created by ke on 2024/5/14.
//

import Foundation

struct StructTypeA {
    var a: Int?
    struct StructTypeB {
        var b: Int?
    }
}

struct CopyMeaning {
    var a: Int
}

func canInOutHasReferenceMeaning(copyOne: inout CopyMeaning) {
    copyOne.a = 10
}
