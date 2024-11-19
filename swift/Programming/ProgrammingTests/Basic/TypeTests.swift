//
//  TypeTests.swift
//  Programming
//
//  Created by ke on 2024/5/17.
//

import Testing

struct TypeTests {
    @Test func testDic() {
        var d = DictionaryType()
        d.dictionary1()
    }
    
    @Test func testArray() {
        var a = ArrayType()
        a.sorted()
    }
    
    @Test func testDecimal() {
        MoneyType()
    }
    
}
