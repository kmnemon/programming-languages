//
//  TypeTests.swift
//  Programming
//
//  Created by ke on 2024/5/17.
//

import XCTest

final class TypeTests: XCTestCase {
    func testDic() {
        var d = DictionaryType()
        d.dictionary1()
    }
    
    func testArray() {
        var a = ArrayType()
        a.sorted()
    }
    
    func testDecimal() {
        MoneyType()
    }
    
}
