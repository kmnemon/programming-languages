//
//  Existential.swift
//  Programming
//
//  Created by ke Liu on 12/12/25.
//

// preserve the concrete element type of an existential collection

func notSupportWithExistential() {
//    let anyIntCollection: any Collection where Element == Int
}

//work-around
protocol IntCollection: Collection where Element == Int {}
extension Array: IntCollection where Element == Int {}



func workAroundWithExistential() {
    let anyIntCollection: any IntCollection = [1, 2, 3]
}
