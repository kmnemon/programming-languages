//
//  LoopInCollection.swift
//  Programming
//
//  Created by ke Liu on 12/21/25.
//

// 1.Normal for loop using collection.indices (✅ safe if NOT mutating)
func forLoopUsingIndices() {
    var numbers = [10, 20, 30, 40]

    // Access both index and value
    for i in numbers.indices {
        print("index:", i, "value:", numbers[i])
    }
}

//2. for loop + mutation that can trigger an unwanted copy (⚠️ performance risk)
//This is what the description warns about.
func warnsForLoop() {
    var numbers = [1, 2, 3, 4, 5]
    
    // ❌ May cause an extra copy
    for i in numbers.indices {
        if numbers[i] % 2 == 0 {
            numbers.remove(at: i)   // structural mutation
        }
    }
}

//3.Correct approach: while loop with manual index (✅ avoids extra copy)
//This is what the Swift documentation recommends when mutating.

func whileLoopInCollection() {
    var numbers = [1, 2, 3, 4, 5]
    
    var i = numbers.startIndex
    
    while i < numbers.endIndex {
        if numbers[i] % 2 == 0 {
            numbers.remove(at: i)
            // do NOT advance i, because elements shift left
        } else {
            numbers.formIndex(after: &i)
        }
    }
}

//4. Example with String (why indices are opaque)
func stringIndex() {
    var text = "hello"
    
    var i = text.startIndex
    while i < text.endIndex {
        if text[i] == "l" {
            text.remove(at: i)
        } else {
            text.formIndex(after: &i)
        }
    }
    
    print(text) // "heo"
}
