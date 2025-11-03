//
//  Subscripts.swift
//  Programming
//
//  Created by ke on 11/3/25.
//

//1. extesion a colloction subscript that support take a list of indices
extension Collection {
    subscript(indices indexList: Index...) -> [Element] {
        var result: [Element] = []
        for index in indexList {
            result.append(self[index])
        }
        return result
    }
}

//Array("adfadfadf")[indices: 1, 2, 4]
