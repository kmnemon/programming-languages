//
//  Collection.swift
//  Programming
//
//  Created by ke on 2024/5/24.
//

import Foundation

//1.Array[String] -> String
extension BidirectionalCollection where Element: StringProtocol {
    var serialized: String {
        count <= 2 ?
            joined(separator: " and ") :
            dropLast().joined(separator: ", ") + ", and " + last!
    }
}

class CollectionType {
    


}
